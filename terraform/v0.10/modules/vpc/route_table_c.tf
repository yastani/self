#--------------------------------------------------------------
# Route Table of Web
#--------------------------------------------------------------
resource "aws_route_table" "web_rt_c" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.ngw_lb_c.id}"
  }

  tags {
    Name = "${lookup(var.prefix, "${terraform.workspace}.prefix")}${lookup(var.route_table, "default.web_subnet_route_table_c_name")}"
  }
}

#--------------------------------------------------------------
# Route Table of Pub
#--------------------------------------------------------------
resource "aws_route_table" "pub_rt_c" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags {
    Name = "${lookup(var.prefix, "${terraform.workspace}.prefix")}${lookup(var.route_table, "default.pub_subnet_route_table_c_name")}"
  }
}

#--------------------------------------------------------------
# Route Table of Data
#--------------------------------------------------------------
resource "aws_route_table" "data_rt_c" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name = "${lookup(var.prefix, "${terraform.workspace}.prefix")}${lookup(var.route_table, "default.data_subnet_route_table_c_name")}"
  }
}
