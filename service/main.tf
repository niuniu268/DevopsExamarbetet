resource "kubernetes_namespace" "app_namespace" {
  metadata {
    name = var.namespace
  }
}

resource "random_password" "mysql_password" {
  length      = 16
  special     = true
  min_numeric = 1
  min_upper   = 1
  min_lower   = 1
  min_special = 1
}

resource "kubernetes_secret" "mysql_credentials" {
  metadata {
    name      = "mysql-credentials"
    namespace = kubernetes_namespace.app_namespace.metadata[0].name
  }

  data = {
    username = var.db_username
    password = random_password.mysql_password.result
  }

  type = "Opaque"
}

resource "kubernetes_config_map" "app_config" {
  metadata {
    name      = "app-config"
    namespace = kubernetes_namespace.app_namespace.metadata[0].name
  }

  data = {
    DB_NAME = var.db_name
    DB_HOST = "mysql-service"
  }
}

resource "kubernetes_persistent_volume" "mysql_pv" {
  metadata {
    name = "mysql-pv"
  }

  spec {
    capacity = {
      storage = "10Gi"
    }
    access_modes = ["ReadWriteOnce"]
    persistent_volume_source {
      host_path {
        path = "/mnt/data"
      }
    }
    storage_class_name = "standard"
  }
}

resource "kubernetes_persistent_volume_claim" "mysql_pvc" {
  metadata {
    name      = "mysql-pvc"
    namespace = kubernetes_namespace.app_namespace.metadata[0].name
  }

  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "10Gi"
      }
    }
    storage_class_name = "standard"
  }
}

resource "kubernetes_deployment" "mysql" {
  metadata {
    name      = "mysql"
    namespace = kubernetes_namespace.app_namespace.metadata[0].name
  }

  spec {
    selector {
      match_labels = {
        app = "mysql"
      }
    }

    template {
      metadata {
        labels = {
          app = "mysql"
        }
      }

      spec {
        container {
          image = "mysql:8.0"
          name  = "mysql"

          env {
            name = "MYSQL_ROOT_PASSWORD"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.mysql_credentials.metadata[0].name
                key  = "password"
              }
            }
          }

          env {
            name = "MYSQL_DATABASE"
            value_from {
              config_map_key_ref {
                name = kubernetes_config_map.app_config.metadata[0].name
                key  = "DB_NAME"
              }
            }
          }

          port {
            container_port = 3306
            name          = "mysql"
          }

          volume_mount {
            name       = "mysql-persistent-storage"
            mount_path = "/var/lib/mysql"
          }
        }

        volume {
          name = "mysql-persistent-storage"
          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim.mysql_pvc.metadata[0].name
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "mysql_service" {
  metadata {
    name      = "mysql-service"
    namespace = kubernetes_namespace.app_namespace.metadata[0].name
  }

  spec {
    selector = {
      app = "mysql"
    }

    port {
      port        = 3306
      target_port = 3306
    }

    cluster_ip = "None"  # Headless service
  }
}

# Deploy Ubuntu VM equivalent
resource "kubernetes_deployment" "ubuntu_vm" {
  metadata {
    name      = "ubuntu-vm"
    namespace = kubernetes_namespace.app_namespace.metadata[0].name
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "ubuntu-vm"
      }
    }

    template {
      metadata {
        labels = {
          app = "ubuntu-vm"
        }
      }

      spec {
        container {
          image = "ubuntu:22.04"
          name  = "ubuntu"

          command = ["/bin/bash", "-c"]
          args = [<<-EOF
            apt-get update && \
            apt-get install -y python3 && \
            echo 'Hello from Ubuntu VM!' > index.html && \
            python3 -m http.server 8000
          EOF
          ]

          resources {
            requests = {
              cpu    = "250m"
              memory = "64Mi"
            }
            limits = {
              cpu    = "500m"
              memory = "128Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "ubuntu_service" {
  metadata {
    name      = "ubuntu-vm-service"
    namespace = kubernetes_namespace.app_namespace.metadata[0].name
    labels = {
      app = "ubuntu-vm"
    }
  }

  spec {
    selector = {
      app = "ubuntu-vm"
    }

    port {
      name        = "http"
      port        = 8000
      target_port = 8000
      protocol    = "TCP"
    }
  }
}

resource "kubernetes_config_map" "coredns_custom" {
  metadata {
    name      = "coredns-custom"
    namespace = "kube-system"
  }

  data = {
    "my-application.server" = <<-EOF
      ${var.namespace}.svc.cluster.local:53 {
          errors
          cache 30
          forward . /etc/resolv.conf
          loop
          reload
      }
    EOF
  }
}

resource "kubernetes_service_account" "dns_service_account" {
  metadata {
    name      = "dns-service-account"
    namespace = kubernetes_namespace.app_namespace.metadata[0].name
  }
}

resource "kubernetes_role" "dns_role" {
  metadata {
    name      = "dns-role"
    namespace = kubernetes_namespace.app_namespace.metadata[0].name
  }

  rule {
    api_groups = [""]
    resources  = ["services", "pods", "endpoints"]
    verbs      = ["get", "list", "watch"]
  }
}

resource "kubernetes_role_binding" "dns_role_binding" {
  metadata {
    name      = "dns-role-binding"
    namespace = kubernetes_namespace.app_namespace.metadata[0].name
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = kubernetes_role.dns_role.metadata[0].name
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.dns_service_account.metadata[0].name
    namespace = kubernetes_namespace.app_namespace.metadata[0].name
  }
}

resource "kubernetes_pod" "dns_debug" {
  metadata {
    name      = "dns-debug"
    namespace = kubernetes_namespace.app_namespace.metadata[0].name
  }

  spec {
    container {
      name  = "dns-debug"
      image = "gcr.io/kubernetes-e2e-test-images/dnsutils:1.3"
      
      command = ["sleep", "3600"]
      
      resources {
        limits = {
          cpu    = "100m"
          memory = "128Mi"
        }
        requests = {
          cpu    = "50m"
          memory = "64Mi"
        }
      }
    }

    service_account_name = kubernetes_service_account.dns_service_account.metadata[0].name
  }
}

resource "kubernetes_service" "dns_test_service" {
  metadata {
    name      = "dns-test-service"
    namespace = kubernetes_namespace.app_namespace.metadata[0].name
  }

  spec {
    selector = {
      app = kubernetes_pod.dns_debug.metadata[0].name
    }

    port {
      port        = 53
      target_port = 53
      protocol    = "UDP"
    }
  }
}