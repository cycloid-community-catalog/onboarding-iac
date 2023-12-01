# Cycloid
variable "customer" {}
variable "env" {}
variable "project" {}

variable "keypair_name" {
  description = "Public key to provision to the instance."
  default = "${var.customer}-${var.project}-${var.env}"
}

variable "keypair_public" {
  description = "Public key to create."
  default = ""
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