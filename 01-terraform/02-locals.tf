locals {
  name_prefix = "k8s"
  image_name  = "noble"
  platform    = try(var.platform, "unk")
  vm_domains = {
    hyperv = ".mshome.net"
    unk    = ""
  }
  vm_domain = local.vm_domains[local.platform]
}
