resource "null_resource" "kubernetes_api_gateway" {
  provisioner "local-exec" {
    command = <<-EOF
      kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.2.0/standard-install.yaml
    EOF
  }

  provisioner "local-exec" {
    when    = destroy
    command = <<-EOF
      kubectl delete -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.2.0/standard-install.yaml
    EOF
  }
}

resource "helm_release" "cert_manager" {
  name             = "cert-manager"
  namespace        = "cert-manager"
  create_namespace = true
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  version          = "v1.16.1"

  values = [<<-YAML
    crds:
      enabled: true
    config:
      apiVersion: controller.config.cert-manager.io/v1alpha1
      kind: ControllerConfiguration
      enableGatewayAPI: true
    podLabels:
      azure.workload.identity/use: "true"
    serviceAccount:
      labels:
        azure.workload.identity/use: "true"
  YAML
  ]

  depends_on = [null_resource.kubernetes_api_gateway]
  
}

resource "helm_release" "helm_istio_base" {
  name             = "istio-base"
  namespace        = "istio-system"
  create_namespace = true
  repository       = "https://istio-release.storage.googleapis.com/charts"
  chart            = "base"
  version          = "1.23.3"

  values = [<<-YAML
    global:
      istioNamespace: istio-system
  YAML
  ]
}

resource "helm_release" "helm_istiod" {
  name             = "istiod"
  namespace        = "istio-system"
  create_namespace = true
  repository       = "https://istio-release.storage.googleapis.com/charts"
  chart            = "istiod"
  version          = "1.23.3"

  values = [<<-YAML
    pilot:
      autoscaleMin: 2
      resources:
        requests:
          cpu: 20m
          memory: 80Mi
    global:
      istioNamespace: istio-system
  YAML
  ]

  depends_on = [helm_release.helm_istio_base]
}

resource "helm_release" "helm_istio_ingress" {
  name             = "istio-ingressgateway"
  namespace        = "istio-system"
  create_namespace = true
  repository       = "https://istio-release.storage.googleapis.com/charts"
  chart            = "gateway"
  version          = "1.23.3"

  values = [<<-YAML
    service:
      type: LoadBalancer
      ports:
        - name: http2
          port: 80
          targetPort: 8080
    labels:
      app: istio-ingressgateway
      istio: ingressgateway
  YAML
  ]

  depends_on = [helm_release.helm_istiod]
}

resource "kubernetes_namespace" "istio_gateway" {
  metadata {
    name = "istio-gateway"
    labels = {
      istio-injection = "enabled"
    }
  }

  depends_on = [helm_release.helm_istiod]
}

resource "helm_release" "helm_istio_gateway" {
  name             = "istio-gateway"
  namespace        = "istio-gateway"
  create_namespace = true
  repository       = "https://bedag.github.io/helm-charts"
  chart            = "raw"
  version          = "v2.0.0"

  values = [<<-YAML
    templates:
      - |
        apiVersion: gateway.networking.k8s.io/v1beta1
        kind: Gateway
        metadata:
          name: kubernetes-gateway
          namespace: istio-gateway
        spec:
          gatewayClassName: istio
          listeners:
            - name: http
              port: 80
              protocol: HTTP
              allowedRoutes:
                namespaces:
                  from: All
      - |
        apiVersion: gateway.networking.k8s.io/v1beta1
        kind: HTTPRoute
        metadata:
          name: ubuntu-route
          namespace: microservices-application-ns
        spec:
          parentRefs:
            - name: kubernetes-gateway
              namespace: istio-gateway
          rules:
            - matches:
                - path:
                    type: PathPrefix
                    value: /
              backendRefs:
                - name: ubuntu-vm-service
                  port: 8000
                  kind: Service
  YAML
  ]
}

data "kubernetes_service" "ingress_gateway" {
  metadata {
    name      = "istio-ingressgateway"
    namespace = "istio-system"
  }
  depends_on = [helm_release.helm_istio_ingress]
}