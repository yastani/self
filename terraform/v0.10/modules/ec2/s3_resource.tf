#--------------------------------------------------------------
# Create a cloudfront origin access identity
#--------------------------------------------------------------
resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "${lookup(var.prefix, "${terraform.workspace}.prefix")}resource"
}

#--------------------------------------------------------------
# Create a s3 resource bucket
#--------------------------------------------------------------
data "aws_caller_identity" "resource_bucket" {}

data "template_file" "s3_resource_bucket_policy" {
  template = "${file("policy-files/s3_resource_bucket.json")}"

  vars {
    s3_resource_bucket_name = "${lookup(var.prefix, "${terraform.workspace}.prefix")}resource"
    origin_access_identity  = "${aws_cloudfront_origin_access_identity.origin_access_identity.id}"
  }
}

resource "aws_s3_bucket" "resource_bucket" {
  bucket        = "${lookup(var.prefix, "${terraform.workspace}.prefix")}resource"
  acl           = "private"
  force_destroy = false
  policy        = "${data.template_file.s3_resource_bucket_policy.rendered}"

  tags {
    Name = "${lookup(var.prefix, "${terraform.workspace}.prefix")}resource"
  }

  tags {
    Datadog = "${terraform.workspace == "prod" ? "monitored" : ""}"
  }
}
