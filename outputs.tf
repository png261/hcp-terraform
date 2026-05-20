output "bucket_name" {
  description = "Demo S3 bucket name."
  value       = aws_s3_bucket.test_bucket.id
}

output "security_group_id" {
  description = "Demo security group ID."
  value       = aws_security_group.test_sg.id
}
