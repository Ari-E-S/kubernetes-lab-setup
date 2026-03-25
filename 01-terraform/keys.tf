# ED25519 key
resource "tls_private_key" "ed25519-key-ubuntu" {
  algorithm = "ED25519"
}

resource "local_file" "ed25519-key-ubuntu" {
  content         = tls_private_key.ed25519-key-ubuntu.private_key_openssh
  filename        = "${path.module}/../02-ansible/keys/ed25519-key-ubuntu"
  file_permission = "0600"
}
