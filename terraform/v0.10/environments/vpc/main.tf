module "vpc" {
  source      = "../../modules/vpc"
  prefix      = "${var.prefix}"
  region      = "${var.region}"
  vpc         = "${var.vpc}"
  subnet      = "${var.subnet}"
  route_table = "${var.route_table}"
}
