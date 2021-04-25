# Terraform Variables
variable "aws_region" {
  description = "AWS Default Region"
  type        = string
  default     = "us-east-1"
}

variable "prefix" {
  description = "To apply generic naming to AWS VPC Resources"
  type        = string
  default     = "copper"
}

variable "environment" {
  description = "To apply generic environment to AWS VPC Resources"
  type        = string
  default     = "devops"
}

variable "cidr" {
  description = "CIDR block value to define the size of the AWS VPC"
  type        = string
  default     = "10.0.0.0/20"
}