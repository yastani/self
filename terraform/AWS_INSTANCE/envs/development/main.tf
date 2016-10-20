module "development" {
    source = "../../"

    name                            = "${var.name}"
    region                          = "${var.region}"
    vpc_cidr                        = "${var.vpc_cidr}"
    instance_types                  = "${var.instance_types}"
    ec2_keypair_name                = "${var.ec2_keypair_name}"
}