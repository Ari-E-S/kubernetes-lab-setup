module "k8s_controllers" {
  source = "./modules/multipass"

  cloud_init_vars = {
    public_key_ubuntu = tls_private_key.ed25519-key-ubuntu.public_key_openssh,
    platform          = local.platform,
  }

  instance_count = var.controller_count
  image_name     = local.image_name
  name_prefix    = local.name_prefix
  name           = "control"
  cpus           = 2
  memory         = "2G"
  disks          = "10G"

  first_is_primary = true

  static_ip_network = "Internal Switch"
  static_ip_start   = 10
}

module "k8s_workers" {
  source = "./modules/multipass"

  cloud_init_vars = {
    public_key_ubuntu = tls_private_key.ed25519-key-ubuntu.public_key_openssh,
    platform          = local.platform,
  }
  instance_count = var.worker_count
  image_name     = local.image_name
  name_prefix    = local.name_prefix
  name           = "worker"
  cpus           = 2
  memory         = "2G"
  disks          = "10G"

  static_ip_network = "Internal Switch"
  static_ip_start   = 20
}
