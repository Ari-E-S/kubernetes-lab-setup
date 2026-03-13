locals {
  name_prefix = "k8s"
  image_name  = "noble"
}

module "k8s_controllers" {
  source = "./modules/multipass"

  cloud_init     = templatefile("${path.module}/templates/user_data.yaml.tftpl", {
    public_key_ubuntu = tls_private_key.ed25519-key-ubuntu.public_key_openssh
  })
  instance_count = 1
  image_name     = local.image_name
  name_prefix    = local.name_prefix
  name           = "controller"
  cpus           = 2
  memory         = "4G"
  disks          = "10G"
}

module "k8s_workers" {
  source = "./modules/multipass"

  cloud_init     = templatefile("${path.module}/templates/user_data.yaml.tftpl", {
    public_key_ubuntu = tls_private_key.ed25519-key-ubuntu.public_key_openssh
  })
  instance_count = 2
  image_name     = local.image_name
  name_prefix    = local.name_prefix
  name           = "worker"
  cpus           = 2
  memory         = "4G"
  disks          = "10G"
}
