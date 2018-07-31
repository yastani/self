#--------------------------------------------------------------
# Security Group of aurora
#--------------------------------------------------------------
resource "aws_security_group" "aurora_sg" {
  name        = "${lookup(var.prefix, "${terraform.workspace}.prefix")}aurora-sg"
  description = "${lookup(var.prefix, "${terraform.workspace}.prefix")}aurora-sg"
  vpc_id      = "${lookup(var.vpc, "vpc_id")}"

  tags {
    Name = "${lookup(var.prefix, "${terraform.workspace}.prefix")}aurora-sg"
  }
}

resource "aws_security_group_rule" "aurora_sg_in_mysql" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  security_group_id = "${aws_security_group.aurora_sg.id}"

  cidr_blocks = [
    "${var.class_a_ip_addrs}",
  ]
}

resource "aws_security_group_rule" "aurora_sg_out_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = "${aws_security_group.aurora_sg.id}"

  cidr_blocks = [
    "${var.all_ip_addrs}",
  ]
}
