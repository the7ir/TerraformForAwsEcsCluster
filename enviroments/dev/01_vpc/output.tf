# VPC Output Values

output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}

output "private_subnets" {
  description = "private_subnets"
  value       = module.vpc.private_subnets
}
output "public_subnets" {
  description = "public_subnets"
  value       = module.vpc.public_subnets
}