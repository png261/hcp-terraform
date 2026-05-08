variable "region" {
  description = "AWS region for all resources."
  type        = string
  default     = "us-west-2"
}

variable "vpc_alpha_cidr" {
  description = "CIDR block for VPC Alpha."
  type        = string
  default     = "10.1.0.0/16"
}

variable "vpc_beta_cidr" {
  description = "CIDR block for VPC Beta."
  type        = string
  default     = "10.2.0.0/16"
}

variable "hosted_zone_name" {
  description = "Private Route 53 hosted zone domain name."
  type        = string
  default     = "internal.example.com"
}
