# Terraform Variables
variable "cluster_prefix" {
  description = "To apply generic naming to AWS VPC Resources"
  type        = string
}

variable "cluster_environment" {
  description = "To apply generic environment to AWS VPC Resources"
  type        = string
}

variable "cluster_architecture" {
  description = "To apply generic cluster architecture to AWS VPC Resources"
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
