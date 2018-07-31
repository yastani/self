#--------------------------------------------------------------
# Private Subnet of Web
#--------------------------------------------------------------
resource "aws_subnet" "web_subnet_d" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${lookup(var.subnet, "default.web_subnet_d_cidr")}"
  availability_zone       = "${lookup(var.region, "default.region")}d"
  map_public_ip_on_launch = false

  tags {
    Name = "${lookup(var.prefix, "${terraform.workspace}.prefix")}${lookup(var.subnet, "default.web_subnet_d_name")}"
  }
}

resource "aws_route_table_association" "web_rta_d" {
  subnet_id      = "${aws_subnet.web_subnet_d.id}"
  route_table_id = "${aws_route_table.web_rt_d.id}"
}

#--------------------------------------------------------------
# Private Subnet of Data
#--------------------------------------------------------------
resource "aws_subnet" "data_subnet_d" {
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${lookup(var.subnet, "default.data_subnet_d_cidr")}"
  availability_zone = "${lookup(var.region, "default.region")}d"

  tags {
    Name = "${lookup(var.prefix, "${terraform.workspace}.prefix")}${lookup(var.subnet, "default.data_subnet_d_name")}"
  }
}

resource "aws_route_table_association" "data_rta_d" {
  subnet_id      = "${aws_subnet.data_subnet_d.id}"
  route_table_id = "${aws_route_table.data_rt_d.id}"
}
