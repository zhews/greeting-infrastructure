variable "name" {
  type = string
}

variable "zone" {
  type    = string
  default = "ch-dk-2"
}

variable "ssh_public_key" {
  type = string
}

variable "security_group_allowed_ports" {
  type    = set(string)
  default = ["22", "8080"]
}

variable "instance_count" {
  type    = number
  default = 2
}

variable "instance_type" {
  type    = string
  default = "standard.tiny"
}

variable "instance_disk_size" {
  type    = number
  default = 10
}
