variable "vpc" {
  type = "map"

  default = {}
}

variable "subnet" {
  type = "map"

  default = {}
}

variable "rds_monitoring_role_arn" {
  type = "string"
}

variable "rds_master_password" {
  type = "string"
}

variable "prefix" {
  type = "map"

  default = {}
}

variable "route53" {
  type = "map"

  default = {}
}

variable "rds" {
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
