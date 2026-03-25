resource "local_file" "ansible_inventory" {
  content = templatefile(
    "${path.module}/templates/ansible_inventory.yaml.tftpl",
    {
      workers     = module.k8s_workers.ipv4,
      controllers = module.k8s_controllers.ipv4,
      vm_domain   = local.vm_domain,
    }
  )
  filename = "${path.module}/../02-ansible/inventory/hosts.yaml"
}
