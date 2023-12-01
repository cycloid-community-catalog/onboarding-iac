output "key_pair_name" {
  description = "The name of the key pair"
  value       = aws_key_pair.key_pair.name
}