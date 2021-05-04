variable "prefix" {
  description = "generic naming resources"
  type        = string
}

variable "environment" {
  description = "To apply generic environment to AWS VPC Resources"
  type        = string
}

variable "public_subnet_ids" {
  description = "list of public subnets in order of availability zones so that NAT Gateway's can be created in those respective subnets"
  type        = list(any)
}
