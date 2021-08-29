# Hashicorp Terraform AWS VPC Module
Terraform AWS VPC Module by Source4Learn(Source4Learn is an opensource learning community.)
![Source4Learn](https://github.com/source4learn/terraform-aws-vpc/blob/main/s4l.png?raw=true)

## AWS VPC Module
This AWS Terraform module is designed to implement the common AWS infrastructure patterns such as single or multi-tier. The multi-tier patterns allow users to create infrastructure in separate layers as per the needs of modern applications.

AWS VPC Module will create following resources:
- VPC and Subnets
- Route Tables
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
  source                = "source4learn/vpc/aws"
  version               = "0.1.1"
  cluster_prefix        = "source4learn"
  cluster_environment   = "development"
  cluster_architecture  = "3-tier"
  cidr                  = "10.0.0.0/20"
  subnet_bits           = "4"
}
```

# AWS Multi Layer Architecture
The AWS resources created in the public layers can be accessed publicly(i.e. - frontend servers, load-balancers, bastion instances, etc) but backed resources such as application servers, databases, caching servers will remain in private sections. 

The AWS infrastructure patterns can be categories as follows:

- **Public Layer:** This layer consists of public subnets and has one subnet on each availability zone for high availability.
- **Application Layer:** This layer of AWS infrastructure contains the private subnets and one on each Availability Zone.
- **Database Layer:** The third layer consists of 3 private subnets and the same subnet on each availability zone.

Let's take a brief overview of multi-layers or multi-tier architecture. It divides the AWS infrastructure into layers like - Public, Private, and Storage(Isolated database) layers. The reason behind this implementation is to protect and isolate private layers from any unwanted public access. In other words, the Public layer provides a shield to internal layers of architecture.

To split the AWS infrastructure into multiple tiers and availability zones, please refer to below architectural diagram:</br>
![VPC](https://github.com/source4learn/terraform-aws-vpc/blob/main/vpc.png?raw=true)

AWS allows users to create the multi-tier infrastructure and distribute it across the availability zones of the current region to achieve the high availability of resources.

## 3-tier architecture
A three-tier architecture pattern help will help to design a highly secured, modular, scalable, and fault-tolerant infrastructure. In this approach, the application infrastructure will be divided into a public layer, business logic, and storage layer. The resources in the individual layer are being created separately and they can communicate with specific pre-defined routes and security rules.

Use this approach while implementing a microservices-based application architecture. The internet-facing services like - Frontend servers and bastion instances can be created public layer, app servers can be created in the intermediate application layer, and storage layer can have data services such as databases/caching etc.

This AWS Terraform module will help you to create an AWS VPC with 3-tier by just passing `cluster_architecture` as `3-tier`. Users also need to define the desired VPC size in form of `cidr` and subnet mask as `subnet_bits`.

*Example:* Let's assume that the user needs to create a VPC network with ~4000 hosts available and each subnet should have 254 IP addresses. So the cidr value for vpc would be `x.x.x.x/20` and the expected value for subnet would be `x.x.x.x/24`. But in this Terraform module, it accepts subnet mask value as subnet bits which can be calculated by subtracting the subnet cidr value with vpc cidr value.

```
cluster_architecture  = "3-tier"
cidr                  = "10.0.0.0/20"
subnet_bits           = "4"
```

## 2-tier architecture
The two-tier pattern is suitable for that application architecture which requires the isolation between the presentation and business logic without increasing the complexity of application infrastructure.

```
cluster_architecture  = "2-tier"
cidr                  = "10.0.0.0/20"
subnet_bits           = "4"
```

## 1-tier architecture
This single tier architecture can be used for monolythic infrastructures(Highly in-secure) and test/devlopment environments.

```
cluster_architecture  = "1-tier"
cidr                  = "10.0.0.0/20"
subnet_bits           = "4"
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

## Summary

If you encounter an error or problem in this setup, please report in the GitHub repository issues.</br>
Reach us in case you need any further assistance.

Email: source4learn@gmail.com

Twitter: ![@source4learn](https://twitter.com/source4learn/)

LinkedIn: ![linkedin.com/in/source4learn](https://www.linkedin.com/in/source4learn/)
