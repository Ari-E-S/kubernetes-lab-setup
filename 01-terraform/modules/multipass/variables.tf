variable "cloud_init_file" {
  type    = string
  default = null
}

variable "cloud_init" {
  type    = string
  default = null
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
