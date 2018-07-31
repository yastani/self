#--------------------------------------------------------------
# AMI for batch server
#--------------------------------------------------------------
data "aws_ami" "batch" {
  most_recent = true

  owners = [
    "self",
  ]

  filter {
    name = "image-id"

    values = [
      "${lookup(var.ec2, "${terraform.workspace}.batch_server_ami_id")}",
    ]
  }
}

#--------------------------------------------------------------
# Instance for batch server
#--------------------------------------------------------------
resource "aws_instance" "batch" {
  count                = "${lookup(var.ec2, "default.batch_server_num")}"
  ami                  = "${data.aws_ami.batch.id}"
  instance_type        = "${lookup(var.ec2, "${terraform.workspace}.batch_server_type")}"
  subnet_id            = "${element(split(",",lookup(var.subnet, "web_subnet_ids")),0)}"
  key_name             = "${lookup(var.ec2, "${terraform.workspace}.key_name")}"
  iam_instance_profile = "${terraform.workspace == "prod" ? lookup(var.prod_ec2_profile, "batch_name") : lookup(var.stage_ec2_profile, "batch_name")}"

  vpc_security_group_ids = [
    "${aws_security_group.batch_sg.id}",
  ]

  tags {
    Name = "${lookup(var.prefix, "${terraform.workspace}.prefix")}batch"
  }

  tags {
    InternalDomainName = "${lookup(var.ec2, "default.batch_internal_domain_name")}"
  }

  tags {
    Datadog = "${terraform.workspace == "prod" ? "monitored" : ""}"
  }

  tags {
    Environment = "${terraform.workspace}"
  }
}
