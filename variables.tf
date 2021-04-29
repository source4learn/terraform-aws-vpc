# Terraform Variables
variable "aws_region" {
  description = "AWS Default Region"
  type        = string
}

variable "prefix" {
  description = "To apply generic naming to AWS VPC Resources"
  type        = string
}

variable "environment" {
  description = "To apply generic environment to AWS VPC Resources"
  type        = string
}

variable "cidr" {
  description = "CIDR block value to define the size of the AWS VPC"
  type        = string
  default     = "10.0.0.0/20"
}

variable "subnet_bits" {
  description = "Subnet bits for cidrsubnet interpolation or Size we need to define for the Subnet (cidr of VPC + Subnet bits)"
  type        = string
}
