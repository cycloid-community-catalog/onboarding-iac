# Cycloid
variable "customer" {}
variable "env" {}
variable "project" {}

# Infra
variable "vm_instance_type" {
  description = "Instance type to deploy."
  default     = "t2.micro"
}

variable "vm_disk_size" {
  description = "Disk size for the instance (Go)"
  default = "20"
}

variable "vm_os_user" {
  description = "Admin username to connect to instance via SSH. Set to 'admin' because we use debian OS."
  default     = "admin"
}

variable "keypair_name" {
  description = "The name of the key pair to provision to the instance."
  default = "${var.customer}-${var.project}-${var.env}"
}

variable "associate_public_ip_address" {
  description = "Whether to associate a public IP on the primary interface or not."
  default = true
}

# Network
variable "subnet_id" {
  description = "Subnet ID where to deploy the EC2 instance."
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