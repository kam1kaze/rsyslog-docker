variable "name" {
  description = "Name to be used on all resources as prefix"
}

variable "instance_type" {
  description = "The type of instance to start"
  default     = "t2.micro"
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  default     = {}
}

variable "subnet_id" {}
variable "user_data" {}

variable "ebs_block_device" {
  default = []
}
