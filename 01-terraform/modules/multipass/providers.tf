terraform {
  required_providers {
    multipass = {
      source  = "todoroff/multipass"
      version = ">= 1.5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.0.0"
    }
  }
}
