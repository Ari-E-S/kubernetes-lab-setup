output "ipv4" {
  description = "IP addresses for each instance"
  value = {
    for instance in multipass_instance.this :
    instance.id => element(instance.ipv4, 0)
  }
}

output "name" {
  description = "Array of names of instances"
  value = [
    for instance in multipass_instance.this : instance.id
  ]
}

output "instances" {
  description = "Array of the complete instance list"
  value = multipass_instance.this
}
