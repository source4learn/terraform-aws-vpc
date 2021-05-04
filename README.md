# Hashicorp Terraform AWS VPC Module
Terraform AWS VPC Module by Source4Learn(An Opensource Community to learn and share knowledge)
![s4l](s4l.png "Source4Learn")

## AWS VPC Module Usage
This AWS VPC Module will creates 1/2/3 tier resources as per user inputs:
- Subnets ["Public", "Private", "Storage"]
- Route Tables ["Public", "Private", "Storage"]
- Security Gruoups
- Internet Gateway
- NAT Gateway
- Elatic IPs
- Network ACLs
- VPC Endpoints

Example: Single tier AWS VPC architecture having only Public Subnet with required resources.

```terraform
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/20"

  tags = {
    Name        = "my-vpc"
    Environment = "my-environment"
  }
}

# AWS VPC Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "my-igw"
    Environment = "my-environment"
  }
}

# AWS VPC Subnets Module - Public Subnet
module "public_subnet" {
  source                  = "./modules/subnets"
  vpc_id                  = aws_vpc.vpc.id
  aws_internet_gateway_id = aws_internet_gateway.igw.id
  cidr                    = "10.0.0.0/20"
  subnet_bits             = "4"
  prefix                  = "my-subnet"
  environment             = "my-environment"
  subnet_type             = ["public"]
}
```

In adadition to above example, users can provision 2/3 tier AWS VPC architecture.

```terraform
module "nat_gateway" {
  source            = "./modules/nat-gateways"
  prefix            = "my-nat-gateway"
  environment       = "my-environment"
  public_subnet_ids = module.public_subnet.public_subnet_ids
}

module "private_subnet" {
  source             = "./modules/subnets"
  vpc_id             = aws_vpc.vpc.id
  aws_nat_gateway_id = module.nat_gateway.nat_gateway_ids
  cidr               = "10.0.0.0/20"
  subnet_bits        = "4"
  prefix             = "my-subnet"
  environment        = "my-environment"
  subnet_type        = ["private", "storage"]
}

module "security_group" {
  source      = "./modules/security-groups"
  vpc_id      = aws_vpc.vpc.id
  prefix      = "my-security-group"
  environment = "my-environment"
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
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Default Region | `string` | n/a | yes |
| <a name="input_cidr"></a> [cidr](#input\_cidr) | CIDR block value to define the size of the AWS VPC | `string` | `"10.0.0.0/20"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | To apply generic environment to AWS VPC Resources | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | To apply generic naming to AWS VPC Resources | `string` | n/a | yes |
| <a name="input_subnet_bits"></a> [subnet\_bits](#input\_subnet\_bits) | Subnet bits for cidrsubnet interpolation or Size we need to define for the Subnet (cidr of VPC + Subnet bits) | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | Terraform Output |
