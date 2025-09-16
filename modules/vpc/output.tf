output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.this_vpc.id
}

output "private_subnet_ids" {
  description = "Private subnet IDs"
  value       = aws_subnet.private_this[*].id
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = aws_subnet.public_this[*].id
}
