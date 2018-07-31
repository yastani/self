variable "region" {
  type = "map"

  default = {}
}

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

variable "prod_ec2_profile" {
  type = "map"

  default = {}
}

variable "stage_ec2_profile" {
  type = "map"

  default = {}
}

variable "ec2" {
  type = "map"

  default = {}
}

variable "route53" {
  type = "map"

  default = {}
}

variable "all_ip_addrs" {
  type = "string"
}

variable "class_a_ip_addrs" {
  type = "string"
}
