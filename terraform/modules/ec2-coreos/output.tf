output "private_ip" {
  description = "Private IP addresses assigned to the instance"
  value       = "${aws_instance.this.private_ip}"
}

output "public_ip" {
  value = "${aws_instance.this.public_ip}"
}
