variable "vpc_id" {
  description = "VPC ID to which subnet mask will bind to"
  type        = string
}

variable "cluster_prefix" {
  description = "generic naming resources"
  type        = string
}

variable "cluster_environment" {
  description = "To apply generic cluster_environment to AWS VPC Resources"
  type        = string
}

