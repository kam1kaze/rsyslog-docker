variable "name" {
  default = "rsyslog-test"
}

variable "key_pairs" {
  default = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAIEAv7GL94f3iMfhqMNCigBgja3kcKeqN46oPs6Gl8S/f5ao8yR1aGj0i0iIg+rjZ4Yjv7IVe6WY/WU9gww0pm7DrT/f9oyvixKUoVG6U1/rkXCjtMPuSJMPt7E+C9dE0QCPQnZulLUHlgciKBDFjoimpnZpwEAc74B8vdc4ZdGZ+Nk=",
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

data "template_file" "server_cloud_init" {
  template = "${file(format("%s/templates/server-cloud-init.yml", path.module))}"

  vars {
    key_pairs = "${join("\n  - ", var.key_pairs)}"
  }
}

module "rsyslog_server" {
  source    = "modules/ec2-coreos"
  name      = "${var.name}-server"
  user_data = "${data.template_file.server_cloud_init.rendered}"
  subnet_id = "${module.vpc.public_subnets[0]}"

  ebs_block_device = [{
    device_name           = "/dev/xvdb"
    volume_size           = 10
    delete_on_termination = true
  }]

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Name        = "${var.name}-server"
  }
}

data "template_file" "node_cloud_init" {
  template = "${file(format("%s/templates/node-cloud-init.yml", path.module))}"

  vars {
    key_pairs = "${join("\n  - ", var.key_pairs)}"
    rsyslog_remote_address = "${module.rsyslog_server.private_ip}:514"
  }
}

module "worker_node" {
  source    = "modules/ec2-coreos"
  name      = "${var.name}-node"
  user_data = "${data.template_file.node_cloud_init.rendered}"
  subnet_id = "${module.vpc.public_subnets[0]}"

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Name        = "${var.name}-node"
  }
}
