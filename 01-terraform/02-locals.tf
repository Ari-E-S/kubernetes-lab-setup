locals {
  name_prefix = "k8s"
  image_name  = "noble"
  platform    = try(var.platform, "unk")
  vm_domains = {
    hyperv = "mshome.net"
  }
  vm_domain = try(local.vm_domains[local.platform], "")
}
