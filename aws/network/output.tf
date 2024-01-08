output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}

output "private_subnet_id" {
  value = aws_subnet.private_subnet.id
}

output "nat_gateway_ip" {
  value = one(aws_eip.nat_gateway[*].public_ip)
}