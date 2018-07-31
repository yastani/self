module "cloudfront" {
  source = "../../modules/cloudfront"
  vpc    = "${data.terraform_remote_state.vpc.vpc}"
  ec2    = "${data.terraform_remote_state.ec2.ec2}"
  s3     = "${data.terraform_remote_state.ec2.s3}"

  prefix     = "${var.prefix}"
  route53    = "${var.route53}"
  cloudfront = "${var.cloudfront}"
  origin     = "${var.origin}"
  behivior   = "${var.behivior}"
}
