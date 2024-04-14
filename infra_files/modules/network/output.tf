# Return the VPC, Public, Private and Database Route Table
output "vpc" {
  description = "Return VPC object"
  value       = aws_vpc.vpc
}

output "public_rt" {
  description = "Return Public Route Table"
  value       = aws_route_table.public_rt
}

output "private_rt" {
  description = "Return Private Route Table"
  value = aws_route_table.private_rt
}

output "database_rt" {
  description = "Return Database Route Table"
  value       = aws_route_table.database_rt
}