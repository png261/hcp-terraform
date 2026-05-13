variable "instance_name" {
  description = "Value of the EC2 instance's Name tag."
  type        = string
  default     = "learn-terraform"
}

variable "instance_type" {
  description = "The EC2 instance's type."
  type        = string
  default     = "t2.micro"
}

variable "s3_bucket_name" {
  description = "Name of the S3 bucket with encryption and versioning."
  type        = string
  default     = "learn-hcp-terraform-bucket"
}
