output "worker_public_ip" {
  value = "${module.worker_node.public_ip}"
}

output "rsyslog_relay_public_ip" {
  value = "${module.rsyslog_relay.public_ip}"
}

output "rsyslog_storage_public_ip" {
  value = "${module.rsyslog_storage.public_ip}"
}
