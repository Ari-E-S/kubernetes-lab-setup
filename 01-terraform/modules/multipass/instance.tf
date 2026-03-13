resource "multipass_instance" "this" {
  count  = var.instance_count
  name   = join("-", [var.name_prefix, var.name, count.index + 1])
  image  = var.image_name
  cpus   = var.cpus
  memory = var.memory
  disk   = var.disks

  cloud_init_file = var.cloud_init_file
  cloud_init      = var.cloud_init

  dynamic "networks" {
    for_each = var.networks
    content {
      name = networks.value.name
      mode = networks.value.mode
      mac  = networks.value.mac
    }
  }

  dynamic "mounts" {
    for_each = var.mounts
    content {
      host_path     = mounts.value.host_path
      instance_path = mounts.value.instance_path
      read_only     = mounts.value.read_only
    }
  }

}
