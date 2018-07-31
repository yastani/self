module "ec2" {
  source            = "../../modules/ec2"
  vpc               = "${data.terraform_remote_state.vpc.vpc}"
  subnet            = "${data.terraform_remote_state.vpc.subnet}"
  prod_ec2_profile  = "${data.terraform_remote_state.prod_iam.ec2_profile}"
  stage_ec2_profile = "${data.terraform_remote_state.stage_iam.ec2_profile}"

  region  = "${var.region}"
  prefix  = "${var.prefix}"
  ec2     = "${var.ec2}"
  route53 = "${var.route53}"

  all_ip_addrs       = "${var.all_ip_addrs}"
  class_a_ip_addrs   = "${var.class_a_ip_addrs}"
}
