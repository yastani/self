#--------------------------------------------------------------
# Public Subnet of Pub
#--------------------------------------------------------------
resource "aws_subnet" "pub_subnet_d" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${lookup(var.subnet, "default.pub_subnet_d_cidr")}"
  availability_zone       = "${lookup(var.region, "default.region")}d"
  map_public_ip_on_launch = true

  tags {
    Name = "${lookup(var.prefix, "${terraform.workspace}.prefix")}${lookup(var.subnet, "default.pub_subnet_d_name")}"
  }
}

resource "aws_route_table_association" "pub_rta_d" {
  subnet_id      = "${aws_subnet.pub_subnet_d.id}"
  route_table_id = "${aws_route_table.pub_rt_d.id}"
}

#--------------------------------------------------------------
# Public Subnet of LB
#--------------------------------------------------------------
resource "aws_subnet" "lb_subnet_d" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${lookup(var.subnet, "default.lb_subnet_d_cidr")}"
  availability_zone       = "${lookup(var.region, "default.region")}d"
  map_public_ip_on_launch = true

  tags {
    Name = "${lookup(var.prefix, "${terraform.workspace}.prefix")}${lookup(var.subnet, "default.lb_subnet_d_name")}"
  }
}

resource "aws_route_table_association" "pub_rta_lb_d" {
  subnet_id      = "${aws_subnet.lb_subnet_d.id}"
  route_table_id = "${aws_route_table.pub_rt_d.id}"
}
