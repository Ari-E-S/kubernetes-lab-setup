output "ipv4" {
  value = {
    for instance in multipass_instance.this :
    instance.id => toset(instance.ipv4)
  }
}

output "name" {
  value = [
    for instance in multipass_instance.this : instance.id
  ]
}
