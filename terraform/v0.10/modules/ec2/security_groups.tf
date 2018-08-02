#--------------------------------------------------------------
# Security Group for web server
#--------------------------------------------------------------
resource "aws_security_group" "web_sg" {
  name                   = "${lookup(var.prefix, "${terraform.workspace}.prefix")}web-sg"
  description            = "${lookup(var.prefix, "${terraform.workspace}.prefix")}web-server"
  vpc_id                 = "${lookup(var.vpc, "vpc_id")}"
  revoke_rules_on_delete = false

  tags {
    Name = "${lookup(var.prefix, "${terraform.workspace}.prefix")}web-sg"
  }
}

resource "aws_security_group_rule" "web-sg_in_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = "${aws_security_group.web_sg.id}"

  cidr_blocks = [
    "${var.class_a_ip_addrs}",
  ]
}

resource "aws_security_group_rule" "web-sg_in_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = "${aws_security_group.web_sg.id}"

  cidr_blocks = [
    "${var.class_a_ip_addrs}",
  ]
}

resource "aws_security_group_rule" "web-sg_out_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = "${aws_security_group.web_sg.id}"

  cidr_blocks = [
    "${var.all_ip_addrs}",
  ]
}

#--------------------------------------------------------------
# Security Group for provision server
#--------------------------------------------------------------
resource "aws_security_group" "provision_sg" {
  name                   = "${lookup(var.prefix, "${terraform.workspace}.prefix")}provision-sg"
  description            = "${lookup(var.prefix, "${terraform.workspace}.prefix")}provision-server"
  vpc_id                 = "${lookup(var.vpc, "vpc_id")}"
  revoke_rules_on_delete = false

  tags {
    Name = "${lookup(var.prefix, "${terraform.workspace}.prefix")}provision-sg"
  }
}

resource "aws_security_group_rule" "provision_sg_in_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = "${aws_security_group.provision_sg.id}"

  cidr_blocks = [
    "${var.hoge_ip_addrs}",
    "${lookup(var.jenkins_ip_addrs, "${terraform.workspace}.jenkins_ip")}",
    "${lookup(var.melmel_ip_addrs, "default.melmel_ip")}",
  ]
}

resource "aws_security_group_rule" "provision_sg_out_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = "${aws_security_group.provision_sg.id}"

  cidr_blocks = [
    "${var.all_ip_addrs}",
  ]
}

#--------------------------------------------------------------
# Security Group for batch server
#--------------------------------------------------------------
resource "aws_security_group" "batch_sg" {
  name                   = "${lookup(var.prefix, "${terraform.workspace}.prefix")}batch-sg"
  description            = "${lookup(var.prefix, "${terraform.workspace}.prefix")}batch-server"
  vpc_id                 = "${lookup(var.vpc, "vpc_id")}"
  revoke_rules_on_delete = false

  tags {
    Name = "${lookup(var.prefix, "${terraform.workspace}.prefix")}batch-sg"
  }
}

resource "aws_security_group_rule" "batch_sg_in_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = "${aws_security_group.batch_sg.id}"

  cidr_blocks = [
    "${var.class_a_ip_addrs}",
  ]
}

resource "aws_security_group_rule" "batch_sg_out_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = "${aws_security_group.batch_sg.id}"

  cidr_blocks = [
    "${var.all_ip_addrs}",
  ]
}

#--------------------------------------------------------------
# Security Group for admin server
#--------------------------------------------------------------
resource "aws_security_group" "admin_sg" {
  name                   = "${lookup(var.prefix, "${terraform.workspace}.prefix")}admin-sg"
  description            = "${lookup(var.prefix, "${terraform.workspace}.prefix")}admin-server"
  vpc_id                 = "${lookup(var.vpc, "vpc_id")}"
  revoke_rules_on_delete = false

  tags {
    Name = "${lookup(var.prefix, "${terraform.workspace}.prefix")}admin-sg"
  }
}

resource "aws_security_group_rule" "admin-sg_in_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = "${aws_security_group.admin_sg.id}"

  cidr_blocks = [
    "${var.class_a_ip_addrs}",
  ]
}

resource "aws_security_group_rule" "admin-sg_in_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = "${aws_security_group.admin_sg.id}"

  cidr_blocks = [
    "${var.class_a_ip_addrs}",
  ]
}

resource "aws_security_group_rule" "admin-sg_out_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = "${aws_security_group.admin_sg.id}"

  cidr_blocks = [
    "${var.all_ip_addrs}",
  ]
}

#--------------------------------------------------------------
# Security Group for web alb
#--------------------------------------------------------------
resource "aws_security_group" "web_alb_sg" {
  name                   = "${lookup(var.prefix, "${terraform.workspace}.prefix")}web-alb-sg"
  description            = "${lookup(var.prefix, "${terraform.workspace}.prefix")}web-alb"
  vpc_id                 = "${lookup(var.vpc, "vpc_id")}"
  revoke_rules_on_delete = false

  tags {
    Name = "${lookup(var.prefix, "${terraform.workspace}.prefix")}web-alb-sg"
  }
}

resource "aws_security_group_rule" "web_alb_sg_in_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = "${aws_security_group.web_alb_sg.id}"

  cidr_blocks = [
    "${var.all_ip_addrs}",
  ]
}

resource "aws_security_group_rule" "web_alb_sg_in_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = "${aws_security_group.web_alb_sg.id}"

  cidr_blocks = [
    "${var.all_ip_addrs}",
  ]
}

resource "aws_security_group_rule" "web_alb_sg_out_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = "${aws_security_group.web_alb_sg.id}"

  cidr_blocks = [
    "${var.all_ip_addrs}",
  ]
}
