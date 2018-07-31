variable "prefix" {
  type    = "map"
  default = {}
}

variable "route53" {
  type    = "map"
  default = {}
}

variable "vpc" {
  type    = "map"
  default = {}
}

variable "ec2" {
  type    = "map"
  default = {}
}

variable "s3" {
  type    = "map"
  default = {}
}

variable "cloudfront" {
  type    = "map"
  default = {}
}

variable "origin" {
  type    = "map"
  default = {}
}

variable "behivior" {
  type    = "map"
  default = {}
}

variable "all_ip_addrs" {
  default = "0.0.0.0/0"
}
