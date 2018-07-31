#--------------------------------------------------------------
# Route53 for cloudfront end point
#--------------------------------------------------------------
resource "aws_route53_record" "front_endpoint" {
  provider = "aws"
  zone_id  = "${lookup(var.route53, "zone_id")}"
  name     = "${lookup(var.cloudfront, "${terraform.workspace}.aliases")}"
  type     = "CNAME"
  ttl      = 60

  records = [
    "${aws_cloudfront_distribution.main.domain_name}",
  ]

  depends_on = [
    "aws_cloudfront_distribution.main",
  ]
}
