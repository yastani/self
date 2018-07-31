#--------------------------------------------------------------
# Route53 for rds Internal DNS
#--------------------------------------------------------------
resource "aws_route53_record" "aurora" {
  zone_id = "${lookup(var.route53, "${terraform.workspace}.zone_id")}"
  name    = "${format("aurora-game-%03d", count.index + 1)}.local"
  type    = "CNAME"
  ttl     = 60

  records = [
    "${aws_rds_cluster.cluster.endpoint}",
  ]

  depends_on = [
    "aws_rds_cluster.cluster",
  ]
}

resource "aws_route53_record" "aurora_read" {
  zone_id = "${lookup(var.route53, "${terraform.workspace}.zone_id")}"
  name    = "${format("aurora-read-%03d", count.index + 1)}.local"
  type    = "CNAME"
  ttl     = 60

  records = [
    "${aws_rds_cluster.cluster.reader_endpoint}",
  ]

  depends_on = [
    "aws_rds_cluster.cluster",
  ]
}
