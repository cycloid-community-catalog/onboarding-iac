output "key_pair" {
  description = "The created key pair"
  value       = aws_key_pair.key_pair
}

output "id" {
  description = "The id of the key pair"
  value       = aws_key_pair.key_pair.id
}

output "name" {
  description = "The name of the key pair"
  value       = var.keypair_name
}