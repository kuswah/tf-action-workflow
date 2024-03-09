terraform {
  cloud {
    organization = "krlabterraform"
    workspaces {
      name = "aws-cli-wf"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.38.0"
    }
  }
}
provider "aws" {
  region = "us-west-2"
}
module "mynetmod" {
  source       = "app.terraform.io/krlabterraform/mynetwork/aws"
  version      = "2.0.0"
  cidr_block   = "192.168.1.0/24"
  subnet_az    = ["us-west-2a", "us-west-2b"]
  subnet_cidrs = ["192.168.1.0/25", "192.168.1.128/25"]
}
output "aws_vpc_id" {
  value = module.mynetmod.aws_vpc_id
}
