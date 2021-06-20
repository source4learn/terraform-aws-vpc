# Hashicorp Terraform AWS VPC Module
Terraform AWS VPC Module by Source4Learn(An Opensource Community to learn and share knowledge)
![Source4Learn](https://github.com/opensource4learn/terraform-aws-vpc/blob/main/s4l.png?raw=true)

## AWS VPC Module
This AWS VPC Module will create following resources:
- Subnets ["Public", "Private", "Storage"]
- Route Tables ["Public", "Private", "Storage"]
- Security Gruoups
- Internet Gateway
- NAT Gateway
- Elatic IPs
- Network ACLs
- VPC Endpoints

## Usage

```terraform
provider "aws" {
  region = "ap-south-1"
}

module "vpc" {
  source                = "opensource4learn/vpc/aws"
  version               = "0.1.0-beta"
  cluster_prefix        = "source4learn"
  cluster_environment   = "development"
  cluster_architecture  = "3-tier"
  cidr                  = "10.0.0.0/20"
  subnet_bits           = "4"
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_nat_gateway"></a> [nat\_gateway](#module\_nat\_gateway) | ./modules/nat-gateways |  |
| <a name="module_private_subnet"></a> [private\_subnet](#module\_private\_subnet) | ./modules/subnets |  |
| <a name="module_public_subnet"></a> [public\_subnet](#module\_public\_subnet) | ./modules/subnets |  |
| <a name="module_security_group"></a> [security\_group](#module\_security\_group) | ./modules/security-groups |  |

## Resources

| Name | Type |
|------|------|
| [aws_internet_gateway.igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr"></a> [cidr](#input\_cidr) | CIDR block value to define the size of the AWS VPC | `string` | "10.0.0.0/20" | yes |
| <a name="input_cluster_architecture"></a> [cluster\_architecture](#input\_cluster\_architecture) | To apply generic cluster architecture to AWS VPC Resources | `string` | n/a | yes |
| <a name="input_cluster_environment"></a> [cluster\_environment](#input\_cluster\_environment) | To apply generic environment to AWS VPC Resources | `string` | n/a | yes |
| <a name="input_cluster_prefix"></a> [cluster\_prefix](#input\_cluster\_prefix) | To apply generic naming to AWS VPC Resources | `string` | n/a | yes |
| <a name="input_subnet_bits"></a> [subnet\_bits](#input\_subnet\_bits) | Subnet bits for cidrsubnet interpolation or Size we need to define for the Subnet (cidr of VPC + Subnet bits) | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | Terraform Output |
