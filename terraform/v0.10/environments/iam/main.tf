resource "aws_iam_role" "ec2-provision" {
  name               = "ec2-provision"
  assume_role_policy = "${file("./policy-files/ec2-provision.policy")}"
}

resource "aws_iam_role" "ec2-batch" {
  name               = "ec2-batch"
  assume_role_policy = "${file("./policy-files/ec2-batch.policy")}"
}

resource "aws_iam_role" "ec2-admin" {
  name               = "ec2-admin"
  assume_role_policy = "${file("./policy-files/ec2-admin.policy")}"
}

resource "aws_iam_role" "ec2-web" {
  name               = "ec2-web"
  assume_role_policy = "${file("./policy-files/ec2-web.policy")}"
}

resource "aws_iam_role" "ec2-webdeploy" {
  name               = "ec2-webdeploy"
  assume_role_policy = "${file("./policy-files/ec2-webdeploy.policy")}"
}

resource "aws_iam_role" "ec2-nodejs" {
  name               = "ec2-nodejs"
  assume_role_policy = "${file("./policy-files/ec2-nodejs.policy")}"
}
