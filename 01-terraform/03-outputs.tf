output "workers" {
  value = module.k8s_workers.ipv4
}

output "controllers" {
  value = module.k8s_controllers.ipv4
}
