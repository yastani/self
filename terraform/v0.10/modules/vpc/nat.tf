#--------------------------------------------------------------
# EIP for Pub Nat Gateway
#--------------------------------------------------------------
resource "aws_eip" "eip_ngw_pub" {
  vpc = true
}

#--------------------------------------------------------------
# Nat Gateway of Pub
#--------------------------------------------------------------
resource "aws_nat_gateway" "ngw_pub_a" {
  allocation_id = "${aws_eip.eip_ngw_pub.id}"
  subnet_id     = "${aws_subnet.pub_subnet_a.id}"
}

resource "aws_nat_gateway" "ngw_pub_c" {
  allocation_id = "${aws_eip.eip_ngw_pub.id}"
  subnet_id     = "${aws_subnet.pub_subnet_c.id}"
}

resource "aws_nat_gateway" "ngw_pub_d" {
  allocation_id = "${aws_eip.eip_ngw_pub.id}"
  subnet_id     = "${aws_subnet.pub_subnet_d.id}"
}
