#--------------------------------------------------------------
# Private Subnet of Web
#--------------------------------------------------------------
resource "aws_subnet" "web_subnet_c" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${lookup(var.subnet, "default.web_subnet_c_cidr")}"
  availability_zone       = "${lookup(var.region, "default.region")}c"
  map_public_ip_on_launch = false

  tags {
    Name = "${lookup(var.prefix, "${terraform.workspace}.prefix")}${lookup(var.subnet, "default.web_subnet_c_name")}"
  }
}

resource "aws_route_table_association" "web_rta_c" {
  subnet_id      = "${aws_subnet.web_subnet_c.id}"
  route_table_id = "${aws_route_table.web_rt_c.id}"
}

#--------------------------------------------------------------
# Private Subnet of Data
#--------------------------------------------------------------
resource "aws_subnet" "data_subnet_c" {
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${lookup(var.subnet, "default.data_subnet_c_cidr")}"
  availability_zone = "${lookup(var.region, "default.region")}c"

  tags {
    Name = "${lookup(var.prefix, "${terraform.workspace}.prefix")}${lookup(var.subnet, "default.data_subnet_c_name")}"
  }
}

resource "aws_route_table_association" "data_rta_c" {
  subnet_id      = "${aws_subnet.data_subnet_c.id}"
  route_table_id = "${aws_route_table.data_rt_c.id}"
}
