variable "name" {
    default = "development"
}


variable "region" {
  default = "ap-northeast-1"
}


variable "vpc_cidr" {
    default = "172.16.0.0/16"
}


variable "instance_types" {
    default = {
        "bastion"    = "t2.micro"
        "webapp"     = "t2.micro"
    }
}


variable "ec2_keypair_name" {
  default = "ytani_aws_public"
}


