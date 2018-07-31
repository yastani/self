#--------------------------------------------------------------
# Redis Security Group
#--------------------------------------------------------------
resource "aws_security_group" "redis_sg" {
  name                   = "${lookup(var.prefix, "${terraform.workspace}.prefix")}redis-main-sg"
  description            = "${lookup(var.prefix, "${terraform.workspace}.prefix")}redis-main-sg"
  vpc_id                 = "${lookup(var.vpc, "vpc_id")}"
  revoke_rules_on_delete = false

  tags {
    Name = "${lookup(var.prefix, "${terraform.workspace}.prefix")}redis-main-sg"
  }
}

resource "aws_security_group_rule" "redis_sg_in_redis" {
  type              = "ingress"
  from_port         = 6379
  to_port           = 6379
  protocol          = "tcp"
  security_group_id = "${aws_security_group.redis_sg.id}"

  cidr_blocks = [
    "${var.class_a_ip_addrs}",
  ]
}

resource "aws_security_group_rule" "redis_sg_out_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = "${aws_security_group.redis_sg.id}"

  cidr_blocks = [
    "${var.all_ip_addrs}",
  ]
}
