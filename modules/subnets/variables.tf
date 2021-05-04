variable "vpc_id" {
  description = "VPC id to which subnet mask will bind to"
  type        = string
}

variable "aws_internet_gateway_id" {
  description = "Internet Gateway id to connect to public subnet"
  type        = string
  default     = ""
}

variable "aws_nat_gateway_id" {
  description = "NAT Gateway ids sort by the availability zone names to bind with the subnet mask in respective AZs"
  type        = list(any)
  default     = [""]
}

variable "prefix" {
  description = "generic naming resources"
  type        = string
}

variable "environment" {
  description = "To apply generic environment to AWS VPC Resources"
  type        = string
}

variable "subnet_bits" {
  description = "Subnet bits for cidrsubnet interpolation or Size we need to define for the Subnet (cidr of VPC + Subnet bits)"
  type        = string
}

variable "subnet_type" {
  description = "List of type of subnet Eg: ['public', 'private']"
  type        = list(any)
}

variable "cidr" {
  description = "CIDR block value is the size of the VPC"
  type        = string
}
