#--------------------------------------------------------------
# Launch Config for web server
#--------------------------------------------------------------
resource "aws_launch_configuration" "web_launch_conf" {
  name_prefix          = "${lookup(var.prefix, "${terraform.workspace}.prefix")}web-server-default-"
  image_id             = "${lookup(var.ec2, "${terraform.workspace}.webdeploy_server_ami_id")}"
  instance_type        = "${lookup(var.ec2, "${terraform.workspace}.web_server_type")}"
  key_name             = "${lookup(var.ec2, "${terraform.workspace}.key_name")}"
  iam_instance_profile = "${terraform.workspace == "prod" ? lookup(var.prod_ec2_profile, "web_name") : lookup(var.stage_ec2_profile, "web_name")}"

  security_groups = [
    "${aws_security_group.web_sg.id}",
  ]

  lifecycle {
    create_before_destroy = true
  }
}

#--------------------------------------------------------------
# Autoscaling Group for web server
#--------------------------------------------------------------
resource "aws_autoscaling_group" "web_ag" {
  name                      = "${lookup(var.prefix, "${terraform.workspace}.prefix")}web-ag"
  desired_capacity          = "${lookup(var.ec2, "${terraform.workspace}.web_server_num")}"
  max_size                  = "${lookup(var.ec2, "${terraform.workspace}.web_server_max_num")}"
  min_size                  = "${lookup(var.ec2, "${terraform.workspace}.web_server_min_num")}"
  health_check_grace_period = 300
  health_check_type         = "ELB"
  force_delete              = "${terraform.workspace == "prod" ? false : true}"
  launch_configuration      = "${aws_launch_configuration.web_launch_conf.name}"

  enabled_metrics = [
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupMaxSize",
    "GroupMinSize",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances",
  ]

  target_group_arns = [
    "${aws_lb_target_group.web_alb_tg_http.arn}",
  ]

  vpc_zone_identifier = [
    "${element(split(",",lookup(var.subnet, "web_subnet_ids")), 0)}",
  ]

  timeouts {
    delete = "15m"
  }

  tag {
    key                 = "Name"
    value               = "${lookup(var.prefix, "${terraform.workspace}.prefix")}web"
    propagate_at_launch = true
  }

  tag {
    key                 = "Datadog"
    value               = "${terraform.workspace == "prod" ? "monitored" : ""}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = "${terraform.workspace}"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_attachment" "web_ag_attachment_tg_http" {
  autoscaling_group_name = "${aws_autoscaling_group.web_ag.name}"
  alb_target_group_arn   = "${aws_lb_target_group.web_alb_tg_http.arn}"
}
