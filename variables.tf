variable "aws_region" {
  description = "AWS region for the demo resources."
  type        = string
  default     = "us-west-2"
}

variable "demo_suffix" {
  description = "Globally unique suffix for the demo S3 bucket and security group."
  type        = string
  default     = "649519997247-20260520"
}
