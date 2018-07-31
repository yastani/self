#--------------------------------------------------------------
# Public Subnet of Pub
#--------------------------------------------------------------
resource "aws_subnet" "pub_subnet_a" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${lookup(var.subnet, "default.pub_subnet_a_cidr")}"
  availability_zone       = "${lookup(var.region, "default.region")}a"
  map_public_ip_on_launch = true

  tags {
    Name = "${lookup(var.prefix, "${terraform.workspace}.prefix")}${lookup(var.subnet, "default.pub_subnet_a_name")}"
  }
}

resource "aws_route_table_association" "pub_rta_a" {
  subnet_id      = "${aws_subnet.pub_subnet_a.id}"
  route_table_id = "${aws_route_table.pub_rt_a.id}"
}

#--------------------------------------------------------------
# Public Subnet of LB
#--------------------------------------------------------------
resource "aws_subnet" "lb_subnet_a" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${lookup(var.subnet, "default.lb_subnet_a_cidr")}"
  availability_zone       = "${lookup(var.region, "default.region")}a"
  map_public_ip_on_launch = true

  tags {
    Name = "${lookup(var.prefix, "${terraform.workspace}.prefix")}${lookup(var.subnet, "default.lb_subnet_a_name")}"
  }
}

resource "aws_route_table_association" "pub_rta_lb_a" {
  subnet_id      = "${aws_subnet.lb_subnet_a.id}"
  route_table_id = "${aws_route_table.pub_rt_a.id}"
}
