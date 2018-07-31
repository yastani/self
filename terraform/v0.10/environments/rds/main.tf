module "rds" {
  source                  = "../../modules/rds"
  vpc                     = "${data.terraform_remote_state.vpc.vpc}"
  subnet                  = "${data.terraform_remote_state.vpc.subnet}"
  rds_monitoring_role_arn = "${data.aws_iam_role.rds_monitoring_role.arn}"
  rds_master_password     = "${data.aws_kms_secret.rds.master_password}"

  prefix          = "${var.prefix}"
  route53         = "${var.route53}"
  rds             = "${var.rds}"
  parameter_group = "${var.parameter_group}"

  all_ip_addrs     = "${var.all_ip_addrs}"
  class_a_ip_addrs = "${var.class_a_ip_addrs}"
}
