data "aws_ami" "coreos" {
  most_recent = true

  owners = ["595879546273"] # Official CoreOS AMI account

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "name"
    values = ["CoreOS-alpha-*"]
  }
}

data "aws_subnet" "subnet" {
  id = "${var.subnet_id}"
}

resource "aws_security_group" "this" {
  name        = "${var.name}"
  description = "Allow all inbound traffic"
  vpc_id      = "${data.aws_subnet.subnet.vpc_id}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "this" {
  ami                    = "${data.aws_ami.coreos.image_id}"
  instance_type          = "${var.instance_type}"
  vpc_security_group_ids = ["${aws_security_group.this.id}"]
  subnet_id              = "${var.subnet_id}"
  user_data              = "${var.user_data}"
  tags                   = "${var.tags}"
  ebs_block_device       = "${var.ebs_block_device}"
}
