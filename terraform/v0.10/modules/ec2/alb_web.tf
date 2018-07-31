#--------------------------------------------------------------
# Load Balancer for web server
#--------------------------------------------------------------
resource "aws_lb" "web_alb" {
  count                      = "${lookup(var.ec2, "default.web_alb_count")}"
  name                       = "${lookup(var.prefix, "${terraform.workspace}.prefix")}web-alb"
  internal                   = false
  enable_deletion_protection = false

  security_groups = [
    "${aws_security_group.web_alb_sg.id}",
  ]

  subnets = [
    "${split(",",lookup(var.subnet, "lb_subnet_ids"))}",
  ]

  access_logs {
    enabled = true
    prefix  = "web-alb"
    bucket  = "${lookup(var.prefix, "${terraform.workspace}.prefix")}lb-access-log"
  }

  depends_on = [
    "aws_s3_bucket.lb_access_log_bucket",
  ]

  tags {
    Name = "${lookup(var.prefix, "${terraform.workspace}.prefix")}web-alb"
  }

  tags {
    Datadog = "${terraform.workspace == "prod" ? "monitored" : ""}"
  }
}

#--------------------------------------------------------------
# Load Balancer Target Group for web server
#--------------------------------------------------------------
resource "aws_lb_target_group" "web_alb_tg_http" {
  name     = "${lookup(var.prefix, "${terraform.workspace}.prefix")}web-tg-http"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${lookup(var.vpc, "vpc_id")}"

  health_check {
    interval = 30
    path     = "/index.html"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
    matcher             = 200
  }
}

#--------------------------------------------------------------
# Load Balancer Listener for web server
#--------------------------------------------------------------
resource "aws_lb_listener" "web_alb_listener_in_http" {
  load_balancer_arn = "${aws_lb.web_alb.arn}"
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.web_alb_tg_http.arn}"
    type             = "forward"
  }

  depends_on = [
    "aws_lb_target_group.web_alb_tg_http",
  ]
}

resource "aws_lb_listener" "web_alb_listener_in_https" {
  load_balancer_arn = "${aws_lb.web_alb.arn}"
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "${lookup(var.ec2, "${terraform.workspace}.certificate_arn") }"

  default_action {
    target_group_arn = "${aws_lb_target_group.web_alb_tg_http.arn}"
    type             = "forward"
  }

  depends_on = [
    "aws_lb_target_group.web_alb_tg_http",
  ]
}
