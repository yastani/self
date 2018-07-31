#--------------------------------------------------------------
# Cloudfront of main
#--------------------------------------------------------------
resource "aws_cloudfront_distribution" "main" {
  enabled          = true
  comment          = "${lookup(var.prefix, "${terraform.workspace}.prefix")}main-cf"
  price_class      = "${lookup(var.cloudfront, "default.main_price_class")}"
  retain_on_delete = false
  web_acl_id       = "${terraform.workspace == "prod" ? lookup(var.cloudfront, "prod.main_web_acl_id") : lookup(var.cloudfront, "default.main_web_acl_id")}"

  aliases = [
    "${lookup(var.cloudfront, "${terraform.workspace}.aliases")}",
  ]

  logging_config {
    bucket          = "${aws_s3_bucket.main_cf_log_bucket.bucket_domain_name}"
    prefix          = "${lookup(var.prefix, "${terraform.workspace}.prefix")}main-cf"
    include_cookies = false
  }

  viewer_certificate {
    cloudfront_default_certificate = "${lookup(var.behivior, "default.main_viewer_certificate_cloudfront_default_certificate")}"
    acm_certificate_arn            = "${lookup(var.behivior, "${terraform.workspace}.main_viewer_certificate_acm_certificate_arn")}"
    ssl_support_method             = "${lookup(var.behivior, "default.main_viewer_certificate_ssl_support_method")}"
    minimum_protocol_version       = "${lookup(var.behivior, "default.main_viewer_certificate_minimum_protocol_version")}"
  }

  #--------------------------------------------------------------
  # Custom Origins for Backend
  #--------------------------------------------------------------
  origin {
    domain_name = "${lookup(var.ec2, "web_lb_dns_name")}"
    origin_id   = "${lookup(var.ec2, "web_lb_name")}"

    custom_origin_config {
      http_port                = "${lookup(var.origin, "default.main_custom_origin_http_port")}"
      https_port               = "${lookup(var.origin, "default.main_custom_origin_https_port")}"
      origin_keepalive_timeout = "${lookup(var.origin, "default.main_custom_origin_origin_keepalive_timeout")}"
      origin_protocol_policy   = "${lookup(var.origin, "default.main_custom_origin_origin_protocol_policy")}"
      origin_read_timeout      = "${lookup(var.origin, "${terraform.workspace}.main_custom_origin_origin_read_timeout")}"

      origin_ssl_protocols = [
        "TLSv1",
        "TLSv1.1",
        "TLSv1.2",
      ]
    }
  }

  #--------------------------------------------------------------
  # S3 Origins for Frontend
  #--------------------------------------------------------------
  origin {
    domain_name = "${lookup(var.s3, "s3_bucket_domain_name")}"
    origin_id   = "${lookup(var.s3, "s3_bucket_domain_name")}"

    s3_origin_config {
      origin_access_identity = "origin-access-identity/cloudfront/${lookup(var.s3, "s3_cloudfront_oai")}"

      #origin_access_identity = "${aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path}"
    }
  }

  #--------------------------------------------------------------
  # Cache Behavior in html/*
  #--------------------------------------------------------------
  cache_behavior {
    path_pattern           = "html/*"
    min_ttl                = "${terraform.workspace == "prod" ? lookup(var.behivior, "prod.main_default_cache_behavior_min_ttl") : lookup(var.behivior, "default.main_default_cache_behavior_min_ttl")}"
    default_ttl            = "${terraform.workspace == "prod" ? lookup(var.behivior, "prod.main_default_cache_behavior_default_ttl") : lookup(var.behivior, "default.main_default_cache_behavior_default_ttl")}"
    max_ttl                = "${terraform.workspace == "prod" ? lookup(var.behivior, "prod.main_default_cache_behavior_max_ttl") : lookup(var.behivior, "default.main_default_cache_behavior_max_ttl")}"
    target_origin_id       = "${lookup(var.ec2, "web_lb_name")}"
    viewer_protocol_policy = "${lookup(var.behivior, "default.main_default_cache_behavior_viewer_protocol_policy")}"

    allowed_methods = [
      "HEAD",
      "GET",
      "OPTIONS",
    ]

    cached_methods = [
      "HEAD",
      "GET",
      "OPTIONS",
    ]

    forwarded_values {
      cookies {
        forward = "all"
      }

      headers      = ["*"]
      query_string = "${lookup(var.behivior, "default.main_forwarded_values_query_string")}"
    }
  }

  #--------------------------------------------------------------
  # Default Cache Behavior
  #--------------------------------------------------------------
  default_cache_behavior {
    min_ttl                = "${terraform.workspace == "prod" ? lookup(var.behivior, "prod.main_default_cache_behavior_min_ttl") : lookup(var.behivior, "default.main_default_cache_behavior_min_ttl")}"
    default_ttl            = "${terraform.workspace == "prod" ? lookup(var.behivior, "prod.main_default_cache_behavior_default_ttl") : lookup(var.behivior, "default.main_default_cache_behavior_default_ttl")}"
    max_ttl                = "${terraform.workspace == "prod" ? lookup(var.behivior, "prod.main_default_cache_behavior_max_ttl") : lookup(var.behivior, "default.main_default_cache_behavior_max_ttl")}"
    target_origin_id       = "${lookup(var.s3, "s3_bucket_domain_name")}"
    viewer_protocol_policy = "${lookup(var.behivior, "default.main_default_cache_behavior_viewer_protocol_policy")}"
    compress               = true

    allowed_methods = [
      "HEAD",
      "GET",
      "OPTIONS",
      "PUT",
      "POST",
      "DELETE",
      "PATCH",
    ]

    cached_methods = [
      "GET",
      "HEAD",
      "OPTIONS",
    ]

    forwarded_values {
      cookies {
        forward = "none"
      }

      query_string = false
    }
  }

  #--------------------------------------------------------------
  # Restrictions
  #--------------------------------------------------------------
  restrictions {
    geo_restriction {
      restriction_type = "${lookup(var.behivior, "default.main_geo_restriction_restriction_type")}"
    }
  }

  #--------------------------------------------------------------
  # Tags
  #--------------------------------------------------------------
  tags {
    Datadog = "monitored"
  }
}
