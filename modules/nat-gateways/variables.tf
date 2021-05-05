variable "cluster_prefix" {
  description = "generic naming resources"
  type        = string
}

variable "cluster_environment" {
  description = "To apply generic cluster_environment to AWS VPC Resources"
  type        = string
}

variable "public_subnet_ids" {
  description = "list of public subnets in order of availability zones so that NAT Gateway's can be created in those respective subnets"
  type        = list(any)
}
