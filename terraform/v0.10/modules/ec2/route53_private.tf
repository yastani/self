#--------------------------------------------------------------
# Route53 for provision server in Internal DNS
#--------------------------------------------------------------
resource "aws_route53_record" "internal_provision" {
  count   = "${lookup(var.ec2, "default.provision_server_num")}"
  zone_id = "${lookup(var.route53, "${terraform.workspace}.private.zone_id")}"
  name    = "${lookup(var.ec2, "default.provision_internal_domain_name")}"
  type    = "A"
  ttl     = 60

  records = [
    "${aws_instance.provision.private_ip}",
  ]

  depends_on = [
    "aws_instance.provision",
  ]
}

#--------------------------------------------------------------
# Route53 for admin server in Internal DNS
#--------------------------------------------------------------
resource "aws_route53_record" "internal_admin" {
  count   = "${lookup(var.ec2, "default.admin_server_num")}"
  zone_id = "${lookup(var.route53, "${terraform.workspace}.private.zone_id")}"
  name    = "${lookup(var.ec2, "default.admin_internal_domain_name")}"
  type    = "A"
  ttl     = 60

  records = [
    "${aws_instance.admin.private_ip}",
  ]

  depends_on = [
    "aws_instance.admin",
  ]
}

#--------------------------------------------------------------
# Route53 for batch server in Internal DNS
#--------------------------------------------------------------
resource "aws_route53_record" "internal_batch" {
  count   = "${lookup(var.ec2, "default.batch_server_num")}"
  zone_id = "${lookup(var.route53, "${terraform.workspace}.private.zone_id")}"
  name    = "${lookup(var.ec2, "default.batch_internal_domain_name")}"
  type    = "A"
  ttl     = 60

  records = [
    "${aws_instance.batch.private_ip}",
  ]

  depends_on = [
    "aws_instance.batch",
  ]
}
