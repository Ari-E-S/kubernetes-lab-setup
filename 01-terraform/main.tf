locals {
  name_prefix = "k8s"
  image_name  = "noble"
}

locals {
  cloud_init = templatefile("${path.module}/templates/user_data.yaml.tftpl", {
    public_key_ubuntu = tls_private_key.ed25519-key-ubuntu.public_key_openssh,
    platform           = "hyperv",
  })
}

module "k8s_controllers" {
  source = "./modules/multipass"

  cloud_init     = local.cloud_init
  instance_count = 1
  image_name     = local.image_name
  name_prefix    = local.name_prefix
  name           = "controller"
  cpus           = 2
  memory         = "2G"
  disks          = "10G"
}

module "k8s_workers" {
  source = "./modules/multipass"

  cloud_init     = local.cloud_init
  instance_count = 1
  image_name     = local.image_name
  name_prefix    = local.name_prefix
  name           = "worker"
  cpus           = 2
  memory         = "2G"
  disks          = "10G"
}
