# Cycloid
variable "customer" {}
variable "env" {}
variable "project" {}

variable "name" {
  type        = string
  description = "The name of the resource group to create"
  default     = "cycloid"
}

variable "azure_location" {
  description = "Azure location where to create the Resource Group"
  default = "West Europe"
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