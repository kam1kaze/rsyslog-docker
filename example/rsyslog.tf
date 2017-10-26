### Rsyslog Storage Server
data "template_file" "rsyslog_storage_cloud_init" {
  template = "${file(format("%s/templates/rsyslog-storage-cloud-init.yml", path.module))}"

  vars {
    key_pairs = "${join("\n  - ", local.ssh_key_pairs)}"
  }
}

module "rsyslog_storage" {
  source    = "modules/ec2-coreos"
  name      = "${var.name}-storage"
  user_data = "${data.template_file.rsyslog_storage_cloud_init.rendered}"
  subnet_id = "${module.vpc.public_subnets[0]}"

  ebs_block_device = [{
    device_name           = "/dev/xvdb"
    volume_size           = 10
    delete_on_termination = true
  }]

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Name        = "${var.name}-storage"
  }
}


### Rsyslog Relay Server
data "template_file" "rsyslog_relay_cloud_init" {
  template = "${file(format("%s/templates/rsyslog-relay-cloud-init.yml", path.module))}"

  vars {
    key_pairs = "${join("\n  - ", local.ssh_key_pairs)}"
    rsyslog_storage_ip = "${module.rsyslog_storage.public_ip}"
  }
}

module "rsyslog_relay" {
  source    = "modules/ec2-coreos"
  name      = "${var.name}-relay"
  user_data = "${data.template_file.rsyslog_relay_cloud_init.rendered}"
  subnet_id = "${module.vpc.public_subnets[0]}"

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Name        = "${var.name}-relay"
  }
}
