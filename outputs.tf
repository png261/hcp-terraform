output "vpc_alpha_id" {
  description = "ID of VPC Alpha."
  value       = aws_vpc.alpha.id
}

output "vpc_beta_id" {
  description = "ID of VPC Beta."
  value       = aws_vpc.beta.id
}

output "private_hosted_zone_id" {
  description = "ID of the private Route 53 hosted zone."
  value       = aws_route53_zone.private.id
}

output "private_hosted_zone_name_servers" {
  description = "Name servers for the private hosted zone."
  value       = aws_route53_zone.private.name_servers
}

output "alpha_subnets" {
  description = "IDs of the private subnets in VPC Alpha."
  value       = aws_subnet.alpha_private[*].id
}

output "beta_subnets" {
  description = "IDs of the private subnets in VPC Beta."
  value       = aws_subnet.beta_private[*].id
}
