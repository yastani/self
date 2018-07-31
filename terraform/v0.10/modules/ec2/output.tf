output "ec2" {
  value = "${
    map(
      "web_lb_dns_name", "${aws_lb.web_alb.dns_name}",
      "web_lb_name",     "${aws_lb.web_alb.name}",

      "web_security_group_id", "${aws_security_group.web_sg.id}",
      "web_instance_type", "${aws_instance.webdeploy.instance_type}",
      "web_autoscaling_group_name", "${aws_autoscaling_group.web_ag.name}"
    )
  }"
}

output "s3" {
  value = "${
    map(
      "s3_bucket_domain_name", "${aws_s3_bucket.resource_bucket.bucket_domain_name}",
      "s3_bucket_name",        "${aws_s3_bucket.resource_bucket.bucket}",
      "s3_cloudfront_oai",     "${aws_cloudfront_origin_access_identity.origin_access_identity.id}"
    )
  }"
}
