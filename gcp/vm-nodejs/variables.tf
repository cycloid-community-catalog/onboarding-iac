# Cycloid
variable "customer" {}
variable "env" {}
variable "project" {}

# NodeJS App
variable "git_app_url" {
  description = "Public git URL of the web application to build and deploy"
  default = ""
}

# Infra
variable "vm_machine_type" {
  description = "Machine type for the Nexus Repository"
  default     = "n2-standard-2"
}

variable "vm_disk_size" {
  description = "Disk size for the instance (Go)"
  default = "20"
}

variable "network_name" {
  description = "Network name where to deploy the instance."
  default     = ""
}

# Tags
variable "extra_tags" {
  default = {}
}

locals {
  standard_tags = {
    "cycloid" = "true"
    env          = var.env
    project      = var.project
    customer     = var.customer
  }
  merged_tags = merge(local.standard_tags, var.extra_tags)
}