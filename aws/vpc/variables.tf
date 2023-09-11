# Cycloid
variable "customer" {}
variable "env" {}
variable "project" {}

# AWS
variable "keypair_public" {
  description = "The public SSH key, for SSH access to newly-created instances"
}

#
# VPC
#
variable "vpc_cidr" {
  type        = string
  description = "The CIDR of the VPC."
  default     = "10.0.0.0/16"
}

variable "vpc_public_subnet" {
  type        = string
  description = "The public subnet for the VPC."
  default     = "10.0.0.0/24"
}

variable "vpc_private_subnet" {
  type        = string
  description = "The private subnet for the VPC."
  default     = "10.0.1.0/24"
}

#
# Bastion
#
variable "create_bastion" {
  description = "Whether to deploy a bastion instance or not"
  default     = false
}

variable "bastion_instance_type" {
  description = "Instance type for the bastion"
  default     = "t3.micro"
}

# Tags
variable "extra_tags" {
  default = {}
}

locals {
  standard_tags = {
    "cycloid.io" = "true"
    env          = var.env
    project      = var.project
    customer     = var.customer
  }
  merged_tags = merge(local.standard_tags, var.extra_tags)
}