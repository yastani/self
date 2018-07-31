variable "prefix" {
  type = "map"

  default = {}
}

variable "vpc" {
  type = "map"

  default = {}
}

variable "subnet" {
  type = "map"

  default = {}
}

variable "route53" {
  type = "map"

  default = {}
}

variable "elasticache" {
  type = "map"

  default = {}
}

variable "parameter_group" {
  type = "map"

  default = {}
}

variable "all_ip_addrs" {
  type = "string"
}

variable "class_a_ip_addrs" {
  type = "string"
}
