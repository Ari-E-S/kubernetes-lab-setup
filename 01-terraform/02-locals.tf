locals {
  name_prefix = "k8s"
  image_name  = "noble"
  platform    = "hyperv"
  vm_domains = {
    hyperv = "mshome.net"
  }
  vm_domain = try(local.vm_domains[local.platform], "") != "" ? ".${local.vm_domains[local.platform]}" : ""
}
