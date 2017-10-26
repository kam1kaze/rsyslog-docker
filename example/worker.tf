data "template_file" "worker_cloud_init" {
  template = "${file(format("%s/templates/worker-cloud-init.yml", path.module))}"

  vars {
    key_pairs = "${join("\n  - ", local.ssh_key_pairs)}"
    rsyslog_relay_ip = "${module.rsyslog_relay.private_ip}"
  }
}

module "worker_node" {
  source    = "modules/ec2-coreos"
  name      = "${var.name}-worker"
  user_data = "${data.template_file.worker_cloud_init.rendered}"
  subnet_id = "${module.vpc.public_subnets[0]}"

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Name        = "${var.name}-worker"
  }
}
