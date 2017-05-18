variable "name" {}
variable "region" {}
variable "vpc_cidr" {}
variable "instance_types" {
    type = "map"
}
variable "ec2_keypair_name" {}
variable "shared_credentials_file_path" {
  default = "C:/Credentials/AWS/credentials"
}

variable "images" {
    default = {
        AmazonLinux = "ami-374db956"
        RHEL7-2     = "ami-0dd8f963"
        CentOS7-2   = "ami-48517b26"
        CentOS7-1   = "ami-fa65bffa"
        SUSE12      = "ami-f8220896"
        Ubuntu14-04 = "ami-a21529cc"
        WS2012R2    = "ami-760ff517"
    }
}


variable "monitor_url" {
    default = "http://localhost:80"
}