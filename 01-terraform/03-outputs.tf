output "workers" {
  value = module.k8s_workers.instances
}

output "controllers" {
  value = module.k8s_controllers.instances
}
