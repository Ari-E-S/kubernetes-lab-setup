variable "platform" {
  description = "Platform to use for instances (e.g. 'hyperv', 'qemu', etc.)"
  type        = string
  default     = "hyperv"
}

variable "controller_count" {
  description = "Number of control plane nodes to create"
  type        = number
  default     = 0
}

variable "worker_count" {
  description = "Number of worker nodes to create"
  type        = number
  default     = 0
}

variable "controller_cpus" {
  description = "Number of CPUs for each control plane node"
  type        = number
  default     = 2
}

variable "worker_cpus" {
  description = "Number of CPUs for each worker node"
  type        = number
  default     = 2
}

variable "controller_memory" {
  description = "Memory for each control plane node"
  type        = string
  default     = "2G"
}

variable "worker_memory" {
  description = "Memory for each worker node"
  type        = string
  default     = "2G"
}

variable "switch_name" {
  description = "Name of the switch to use for static IPs (Hyper-V only). If null, static IPs will not be configured."
  type        = string
  default     = null
}

variable "static_ip_cidr" {
  description = "CIDR block for static IPs (Hyper-V only)."
  type        = string
  default     = "169.254.0.0"
}

variable "static_ip_mask" {
  description = "Subnet mask for static IPs (Hyper-V only)."
  type        = number
  default     = 24
}

variable "apt_cacher_url" {
  description = "URL for an APT cacher server to speed up package installation in the instances. This will set the APT proxy configuration in the cloud-init script."
  type        = string
  default     = null
}
