#
# VPC outputs
#
output "vpc_id" {
  description = "The VPC ID for the VPC"
  value       = aws_vpc.infra.id
}

output "vpc_cidr" {
  description = "The CIDR for the VPC"
  value       = var.vpc_cidr
}

output "vpc_public_subnet" {
  description = "The public subnet for the VPC"
  value       = var.vpc_public_subnet
}

output "vpc_private_subnet" {
  description = "The private subnet for the VPC"
  value       = var.vpc_private_subnet
}

#
# Bastion outputs
#
output "bastion_ip" {
  description = "The EIP attached to the bastion EC2 server"
  value       = var.create_instance ? aws_instance.bastion[0].public_ip : "Bastion not deployed"
}