output "mysql_password" {
  value       = random_password.mysql_password.result
  sensitive   = true
}

output "mysql_service_name" {
  value       = kubernetes_service.mysql_service.metadata[0].name
}

output "ubuntu_service_name" {
  value       = kubernetes_service.ubuntu_service.metadata[0].name
}