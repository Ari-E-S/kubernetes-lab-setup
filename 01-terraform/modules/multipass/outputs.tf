output "ipv4" {
  value = {
    for instance in multipass_instance.this :
    instance.id => element(instance.ipv4, 0)
  }
}

output "name" {
  value = [
    for instance in multipass_instance.this : instance.id
  ]
}
