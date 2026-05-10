variable "instance_name" {
  description = "Value of the EC2 instance's Name tag."
  type        = string
  default     = "learn-terraform"
}

variable "instance_type" {
  description = "The EC2 instance's type."
  type        = string
  default     = "t3.micro"
}

variable "environment" {
  description = "Environment tag value (e.g., dev, staging, prod)."
  type        = string
  default     = "dev"
}

variable "owner" {
  description = "Owner tag value indicating who owns this resource."
  type        = string
  default     = "hcp-terraform"
}

variable "project" {
  description = "Project tag value indicating the project name."
  type        = string
  default     = "hcp-terraform"
}
