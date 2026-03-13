terraform {
  required_providers {
    multipass = {
      source  = "todoroff/multipass"
      version = "1.5.0"
    }
  }
}

provider "multipass" {
  command_timeout = 10 * 60
}
