variable "cidr_blocks" {
  description = "subnet cidr block"
  type = list(object({
    cidr_block = string
    name = string
  }))
}

variable "my_ip" {} // my public IP address for ssh connection
variable "instance_type" {}
variable "env_prefix" {}
