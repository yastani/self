#--------------------------------------------------------------
# Common - Key
# Terraform 0.10.2 ではproviderでconditionを書けないので一旦この形にしている
#--------------------------------------------------------------
variable "key" {
  type = "map"

  default = {
    # default
    default.credentials_profile = "default"

    # prod
    prod.credentials_profile = "prod"

    # stage
    stage.credentials_profile = "stage"
  }
}

#--------------------------------------------------------------
# Common - Region
#--------------------------------------------------------------
variable "region" {
  type = "map"

  default = {
    # default
    default.region = "ap-northeast-1"
  }
}

#--------------------------------------------------------------
# Common - Prefix
#--------------------------------------------------------------
variable "prefix" {
  type = "map"

  default = {
    # prod
    prod.prefix = "prod"

    # stage
    stage.prefix = "stage1"
  }
}

#--------------------------------------------------------------
# VPC
#--------------------------------------------------------------
variable "vpc" {
  type = "map"

  default = {
    # default
    default.vpc_cidr = "10.0.0.0/16"
  }
}

#--------------------------------------------------------------
# Subnet
#--------------------------------------------------------------
variable "subnet" {
  type = "map"

  default = {
    # cidr

    ## public pub
    default.pub_subnet_a_cidr = "10.0.129.0/24"
    default.pub_subnet_d_cidr = "10.1.129.0/24"

    ## public load balancer
    default.lb_subnet_a_cidr = "10.0.128.0/24"
    default.lb_subnet_c_cidr = "10.0.192.0/24"
    default.lb_subnet_d_cidr = "10.1.128.0/24"

    ## private web
    default.web_subnet_a_cidr = "10.0.0.0/21"
    default.web_subnet_c_cidr = "10.0.64.0/21"
    default.web_subnet_d_cidr = "10.1.0.0/21"

    ## private data
    default.data_subnet_a_cidr = "10.0.9.0/24"
    default.data_subnet_c_cidr = "10.0.73.0/24"
    default.data_subnet_d_cidr = "10.1.9.0/24"

    # subnet

    ## public pub
    default.pub_subnet_a_name = "pub-subnet.apne-1a"
    default.pub_subnet_d_name = "pub-subnet.apne-1d"

    ## public load balancer
    default.lb_subnet_a_name = "lb-subnet.apne-1a"
    default.lb_subnet_c_name = "lb-subnet.apne-1c"
    default.lb_subnet_d_name = "lb-subnet.apne-1d"

    ## private web
    default.web_subnet_a_name = "web-subnet.apne-1a"
    default.web_subnet_c_name = "web-subnet.apne-1c"
    default.web_subnet_d_name = "web-subnet.apne-1d"

    ## private data
    default.data_subnet_a_name = "data-subnet.apne-1a"
    default.data_subnet_c_name = "data-subnet.apne-1c"
    default.data_subnet_d_name = "data-subnet.apne-1d"
  }
}

#--------------------------------------------------------------
# Route table
#--------------------------------------------------------------
variable "route_table" {
  type = "map"

  default = {
    ## data
    default.data_subnet_route_table_name = "data-rt.apne-1"
  }
}
