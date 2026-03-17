variable "controller_count" {
  description = "Number of control plane nodes to create"
  type        = number
  default     = 1
}

variable "worker_count" {
  description = "Number of worker nodes to create"
  type = number
  default = 0
}
