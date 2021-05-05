variable "vpc_id" {
  description = "VPC ID to which subnet mask will bind to"
  type        = string
}

variable "offset" {
  description = "In a series of subnet ids, how many ids to skip"
  type        = string
  default     = "0"
}

variable "cluster_prefix" {
  description = "generic naming resources"
  type        = string
}

variable "cluster_environment" {
  description = "To apply generic cluster_environment to AWS VPC Resources"
  type        = string
}

variable "cidr" {
  description = "CIDR block value is the size of the VPC"
  type        = string
}

variable "create" {
  description = "Set 1 or 0 based on need to create subnet"
  type        = string
}

variable "subnet_bits" {
  description = "Subnet bits for cidrsubnet interpolation or Size we need to define for the Subnet (cidr of VPC + Subnet bits)"
  type        = string
}

variable "subnet_type" {
  description = "Type of subnet Eg: public, private"
  type        = string
}
