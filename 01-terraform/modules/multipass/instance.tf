locals {
  cloud_init_tpl = (
    var.cloud_init_tpl != null ?
    var.cloud_init_tpl :
    "${path.module}/templates/user_data.yaml.tftpl"
  )
}

resource "multipass_instance" "this" {
  count  = var.instance_count
  name   = join("-", [var.name_prefix, var.name, count.index + 1])
  image  = var.image_name
  cpus   = var.cpus
  memory = var.memory
  disk   = var.disks

  cloud_init = templatefile(
    local.cloud_init_tpl,
    merge(
      var.cloud_init_vars,
      {
        static_ip_network = var.static_ip_network,
        static_ip_address = cidrhost(
          "${var.static_ip_cidr}/${var.static_ip_mask}",
          count.index + var.static_ip_start
        ),
        static_mask = var.static_ip_mask,
        static_ip_gateway = cidrhost(
          "${var.static_ip_cidr}/${var.static_ip_mask}",
          1
        ),
        apt_cacher_url = var.apt_cacher_url,
      }
    )
  )
  wait_for_cloud_init = var.wait_for_cloud_init

  primary = (var.first_is_primary && count.index == 0) ? true : false

  # https://dev.to/madalinignisca/how-to-permanent-private-ip-on-multipass-on-windows-with-hyper-v-14k6
  dynamic "networks" {
    for_each = var.static_ip_network != null ? [1] : []
    content {
      name = var.static_ip_network
      mode = "manual"
    }
  }

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
