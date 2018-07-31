#--------------------------------------------------------------
# EIP for provision server
#--------------------------------------------------------------
resource "aws_eip" "provision" {
  vpc = true
}

resource "aws_eip_association" "provision" {
  instance_id   = "${aws_instance.provision.id}"
  allocation_id = "${aws_eip.provision.id}"
}

#--------------------------------------------------------------
# Instance for provision server
#--------------------------------------------------------------
data "aws_ami" "provision" {
  most_recent = true

  owners = [
    "self",
  ]

  filter {
    name = "image-id"

    values = [
      "${lookup(var.ec2, "${terraform.workspace}.provision_server_ami_id")}",
    ]
  }
}

resource "aws_instance" "provision" {
  ami                  = "${data.aws_ami.provision.id}"
  instance_type        = "${lookup(var.ec2, "${terraform.workspace}.provision_server_type")}"
  subnet_id            = "${element(split(",",lookup(var.subnet, "pub_subnet_ids")),0)}"
  key_name             = "${lookup(var.ec2, "${terraform.workspace}.key_name")}"
  iam_instance_profile = "${terraform.workspace == "prod" ? lookup(var.prod_ec2_profile, "provision_name") : lookup(var.stage_ec2_profile, "provision_name")}"

  vpc_security_group_ids = [
    "${aws_security_group.provision_sg.id}",
  ]

  tags {
    Name = "${lookup(var.prefix, "${terraform.workspace}.prefix")}provision"
  }

  tags {
    InternalDomainName = "${lookup(var.ec2, "default.provision_internal_domain_name")}"
  }

  tags {
    Datadog = "${terraform.workspace == "prod" ? "monitored" : ""}"
  }

  tags {
    Environment = "${terraform.workspace}"
  }
}
