#--------------------------------------------------------------
# AMI for admin server
#--------------------------------------------------------------
data "aws_ami" "admin" {
  most_recent = true

  owners = [
    "self",
  ]

  filter {
    name = "image-id"

    values = [
      "${lookup(var.ec2, "${terraform.workspace}.admin_server_ami_id")}",
    ]
  }
}

#--------------------------------------------------------------
# Instance for admin server
#--------------------------------------------------------------
resource "aws_instance" "admin" {
  count                = "${lookup(var.ec2, "default.admin_server_num")}"
  ami                  = "${data.aws_ami.admin.id}"
  instance_type        = "${lookup(var.ec2, "${terraform.workspace}.admin_server_type")}"
  subnet_id            = "${element(split(",",lookup(var.subnet, "pub_subnet_ids")),0)}"
  key_name             = "${lookup(var.ec2, "${terraform.workspace}.key_name")}"
  iam_instance_profile = "${terraform.workspace == "prod" ? lookup(var.prod_ec2_profile, "admin_name") : lookup(var.stage_ec2_profile, "admin_name")}"

  vpc_security_group_ids = [
    "${aws_security_group.admin_sg.id}",
  ]

  tags {
    Name = "${lookup(var.prefix, "${terraform.workspace}.prefix")}admin"
  }

  tags {
    InternalDomainName = "${lookup(var.ec2, "default.admin_internal_domain_name")}"
  }

  tags {
    Datadog = "${terraform.workspace == "prod" ? "monitored" : ""}"
  }

  tags {
    Environment = "${terraform.workspace}"
  }
}
