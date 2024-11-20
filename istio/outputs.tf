output "gateway_namespace" {
  value       = "istio-gateway"
}

output "gateway_name" {
  value       = "kubernetes-gateway"
}

output "load_balancer_ip" {
  value       = data.kubernetes_service.ingress_gateway.status.0.load_balancer.0.ingress.0.ip
}
