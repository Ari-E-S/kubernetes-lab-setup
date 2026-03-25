output "workers" {
  value = module.k8s_workers.ipv4
}

output "controllers" {
  value = module.k8s_controllers.ipv4
}

output "mac_addresses" {
  value = merge(
    module.k8s_workers.mac_address,
    module.k8s_controllers.mac_address
  )
}
