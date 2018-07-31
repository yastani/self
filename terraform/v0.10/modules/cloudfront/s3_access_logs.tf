#--------------------------------------------------------------
# Create a s3 bucket
#--------------------------------------------------------------
data "aws_caller_identity" "current" {}

data "template_file" "main_cf_log_bucket_policy" {
  template = "${file("policy-files/s3_main_cf_log_bucket_policy.json")}"

  vars {
    #--------------------------------------------------------------
    # lb_account_idは再利用性が低いためハードコートしている
    # regionを変更する際は下記URLを参照
    # https://docs.aws.amazon.com/ja_jp/elasticloadbalancing/latest/classic/enable-access-logs.html
    #--------------------------------------------------------------
    lb_account_id = "582318560864"

    aws_account_id = "${data.aws_caller_identity.current.account_id}"
    s3_bucket_name = "${lookup(var.prefix, "${terraform.workspace}.prefix")}main-cf-log"
    prefix         = "${lookup(var.prefix, "${terraform.workspace}.prefix")}main-cf"
  }
}

resource "aws_s3_bucket" "main_cf_log_bucket" {
  bucket        = "${lookup(var.prefix, "${terraform.workspace}.prefix")}main-cf-log"
  acl           = "log-delivery-write"
  policy        = "${data.template_file.main_cf_log_bucket_policy.rendered}"
  force_destroy = true

  tags {
    Name = "${lookup(var.prefix, "${terraform.workspace}.prefix")}main-cf-log"
  }
}
