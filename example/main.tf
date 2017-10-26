variable "name" {
  default = "rsyslog-test"
}

variable "ssh_key" {}

locals {
  ssh_key_pairs = [
    "${var.ssh_key}"
  ]
}

provider "aws" {
  region = "eu-central-1"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.name}"
  cidr = "10.200.0.0/16"

  azs            = ["eu-central-1a", "eu-central-1b"]
  public_subnets = ["10.200.101.0/24", "10.200.102.0/24"]

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
