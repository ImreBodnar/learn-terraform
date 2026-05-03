provider "aws" {
  region = "eu-north-1"
}

# VARIABLES
variable "cidr_blocks" {
    description = "CIDR blocks for VPC and subnets"
    type = list(string)
}
variable "environment" {
    description = "deployment environment"
    default = "staging"
    type = string
}
# Ehhez kell lennie egy TF_VAR_avail_zone nevű környezeti változónak a hoszt gépen.
# variable avail_zone {}

resource "aws_vpc" "development-vpc" {
    cidr_block = var.cidr_blocks[0]
    tags = {
        Name: var.environment
    }
}

resource "aws_subnet" "dev-subnet-1" {
    vpc_id = aws_vpc.development-vpc.id
    cidr_block = var.cidr_blocks[1]
    availability_zone = "eu-north-1a"
    tags = {
        Name: "subnet-1-dev"
    }
}

# OUTPUTS
output "dev-vpc-id" {
    value = aws_vpc.development-vpc.id
}
output "dev-subnet-id" {
    value = aws_subnet.dev-subnet-1.id
}


# JUST SOME EXAMPLES

# data "aws_vpc" "existing_vpc" {
#     default = true
# }

# resource "aws_subnet" "dev-subnet-2" {
#     vpc_id = data.aws_vpc.existing_vpc.id
#     cidr_block = "172.31.48.0/20"
#     availability_zone = "eu-north-1a"
#     tags = {
#         Name: "subnet-2-default"
#     }
# }