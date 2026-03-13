resource "local_file" "ansible_inventory" {
  content = templatefile(
    "${path.module}/templates/ansible_inventory.yaml.tftpl",
    {
      workers     = module.k8s_workers.instances,
      controllers = module.k8s_controllers.instances,
    }
  )
  filename = "${path.module}/../02-ansible/inventory/hosts.yaml"
}
