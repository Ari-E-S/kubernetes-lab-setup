variable "cloud_init_tpl" {
  description = "Template for cloud-init script."
  type        = string
  default     = null
}

variable "cloud_init_vars" {
  description = "Map of variables to apply to the template"
  type        = map(any)
  default     = {}
}

variable "wait_for_cloud_init" {
  description = "Wait for cloud-init to finish after launch before marking the resource as created. Useful when downstream resources depend on packages or configuration applied by cloud-init."
  type        = bool
  default     = true
}

variable "name" {
  type = string
}

variable "image_name" {
  description = "Name of the image to use for the instance."
  type        = string
}

variable "cpus" {
  description = "Number of CPUs for the instance."
  type        = number
}

variable "memory" {
  description = "Memory for the instance."
  type        = string
}

variable "disks" {
  description = "Disk size for the instance."
  type        = string
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
  description = "Map describing a mount. Uses SSHFS to mount files/folders into the VMs."
  type = list(object({
    host_path     = string
    instance_path = string
    read_only     = optional(bool, false)
  }))
  default = []
}

variable "networks" {
  description = "Connect the VM to a network."
  type = list(object({
    name = string
    mode = optional(string, "auto")
    mac  = optional(string, null)
  }))
  default = []
}

variable "static_ip_network" {
  description = "Setup a second network interface with a static MAC address"
  type        = string
  default     = null
}

variable "static_ip_cidr" {
  description = "CIDR for static IP network"
  type        = string
  default     = "10.0.0.0"
}

variable "static_ip_mask" {
  description = "Mask for static IP network"
  type        = number
  default     = 24
}

variable "static_ip_start" {
  description = "Starting IP address for static IP network"
  type        = number
  default     = 10
}

variable "first_is_primary" {
  description = "Set the first instance as primary (only set this for one instance in Multipass)"
  type        = bool
  default     = false
}
