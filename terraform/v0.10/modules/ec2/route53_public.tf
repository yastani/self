#--------------------------------------------------------------
# Route53 for web lb
#--------------------------------------------------------------
resource "aws_route53_record" "prod_web_lb" {
  count    = "${terraform.workspace == "prod" ? 1 : 0}"
  provider = "aws"
  zone_id  = "${lookup(var.route53, "prod.zone_id")}"
  name     = "example.net"
  type     = "CNAME"
  ttl      = 60

  records = [
    "${aws_lb.web_alb.0.dns_name}",
  ]

  depends_on = [
    "aws_lb_listener.web_alb_listener_in_https",
  ]
}
