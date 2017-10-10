output "worker_public_ip" {
  value = "${module.worker_node.public_ip}"
}

output "rsyslog_server_public_ip" {
  value = "${module.rsyslog_server.public_ip}"
}
