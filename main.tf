terraform {
  required_version = "~> 1.6.4"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.19.0"
    }
  }
  cloud {
    organization = "mevijays"

    workspaces {
      name = "clidriven"
    }
  }
}
provider "aws" {
  region = "us-west-2"
}

module "mymod" {
  source  = "app.terraform.io/mevijays/testmod/aws"
  version = "1.0.0"
  instance_type = "t2.micro"
  instance_tags = {Name = "myapp${count.index}", environment = "development"}
}
output "public_ip" {
  value = module.mymod[*].public_ip
}
