variable "cloud_init_tpl" {
  type    = string
  default = null
}

variable "cloud_init_vars" {
  type    = map(any)
  default = {}
}

variable "name" {
  type = string
}

variable "image_name" {
  type = string
}

variable "cpus" {
  type = number
}

variable "memory" {
  type = string
}

variable "disks" {
  type = string
}

variable "instance_count" {
  description = "Number of instances to create"
  type        = number
  default     = 1
}

variable "name_prefix" {
  description = "Instance name prefix"
  type        = string
  default     = "instance"
}

variable "mounts" {
  type = list(object({
    host_path     = string
    instance_path = string
    read_only     = optional(bool, false)
  }))
  default = []
}

variable "networks" {
  type = list(object({
    name = string
    mode = optional(string, "auto")
    mac  = optional(string, null)
  }))
  default = []
}

variable "static_ip_network" {
  type        = string
  default     = null
  description = "Setup a second network interface with a static MAC address"
}

variable "static_ip_cidr" {
  type        = string
  default     = "10.0.0.0"
  description = "CIDR for static IP network"
}

variable "static_ip_mask" {
  type        = number
  default     = 20
  description = "Mask for static IP network"
}

variable "static_ip_start" {
  type        = number
  default     = 10
  description = "Starting IP address for static IP network"
}
