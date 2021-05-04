variable "vpc_id" {
  description = "VPC ID to which subnet mask will bind to"
  type        = string
}

variable "prefix" {
  description = "generic naming resources"
  type        = string
}

variable "environment" {
  description = "To apply generic environment to AWS VPC Resources"
  type        = string
}

variable "sg_type" {
  description = "Security Group type Eg: public, private and storage"
  type        = string
}

variable "sg_description" {
  description = "Generic security group description"
  type        = string
}