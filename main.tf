provider "aws" {
  region = var.aws_region
}

data "aws_vpc" "default" {
  default = true
}

locals {
  name_prefix = "cloudrift-thesis-demo"
}

resource "aws_s3_bucket" "test_bucket" {
  bucket        = "${local.name_prefix}-${var.demo_suffix}"
  force_destroy = true

  tags = {
    Name        = "${local.name_prefix}-${var.demo_suffix}"
    Environment = "thesis-demo"
  }
}

# Thesis drift remediation: terraform apply reconciles induced live drift back to enabled versioning.
resource "aws_s3_bucket_versioning" "test_bucket" {
  bucket = aws_s3_bucket.test_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Thesis drift remediation: terraform apply preserves the intended no-public-SSH security group posture.
resource "aws_security_group" "test_sg" {
  name        = "${local.name_prefix}-${var.demo_suffix}"
  description = "Cloudrift thesis drift detection demo security group"
  vpc_id      = data.aws_vpc.default.id

  egress {
    description = "Allow outbound HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${local.name_prefix}-${var.demo_suffix}"
    Environment = "thesis-demo"
  }
}
