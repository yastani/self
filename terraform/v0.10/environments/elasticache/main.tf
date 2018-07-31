module "elasticache" {
  source = "../../modules/elasticache"
  vpc    = "${data.terraform_remote_state.vpc.vpc}"
  subnet = "${data.terraform_remote_state.vpc.subnet}"

  prefix          = "${var.prefix}"
  route53         = "${var.route53}"
  elasticache     = "${var.elasticache}"
  parameter_group = "${var.parameter_group}"

  all_ip_addrs     = "${var.all_ip_addrs}"
  class_a_ip_addrs = "${var.class_a_ip_addrs}"
}
