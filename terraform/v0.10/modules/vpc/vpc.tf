#--------------------------------------------------------------
# VPC
#--------------------------------------------------------------
resource "aws_vpc" "vpc" {
  cidr_block           = "${lookup(var.vpc, "default.vpc_cidr")}"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags {
    Name = "${lookup(var.prefix, "${terraform.workspace}.prefix")}vpc"
  }
}

#--------------------------------------------------------------
# Internet Gateway
#--------------------------------------------------------------
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name = "${lookup(var.prefix, "${terraform.workspace}.prefix")}igw"
  }
}
