resource "aws_iam_role" "lambda" {
  name = "lambda"
  assume_role_policy = "${file("../../policies/lambda_assume_policy.json")}"
}


resource "aws_iam_policy" "lambda" {
  name = "lambda"
  path = "/"
  description = "for lamdbda policy"
  policy = "${file("../../policies/lambda_role_policy.json")}"
}


resource "aws_iam_policy_attachment" "lambda_role_attachment" {
  name = "lambda_role_attachment"
  roles = ["${aws_iam_role.lambda.name}"]
  policy_arn = "${aws_iam_policy.lambda.arn}"
}


resource "aws_iam_role" "cloudwatch" {
  name ="cloudwatch"
  assume_role_policy = "${file("../../policies/cloudwatch_assume_policy.json")}"
}


resource "aws_iam_policy" "cloudwatch" {
  name = "cloudwatch"
  path = "/"
  description = "for cloudwatch policy"
  policy = "${file("../../policies/cloudwatch_role_policy.json")}"
}


resource "aws_iam_policy_attachment" "cloudwatch_role_attachment" {
  name = "cloudwatch_role_attachment"
  roles = ["${aws_iam_role.cloudwatch.name}"]
  policy_arn = "${aws_iam_policy.cloudwatch.arn}"
}


resource "aws_iam_user" "cloudwatch" {
    name = "cloudwatch"
    path = "/system/"
}


resource "aws_iam_access_key" "cloudwatch" {
    user = "${aws_iam_user.cloudwatch.name}"
}


resource "aws_iam_user_policy" "cw_usr_pol" {
    name = "cloudwatch"
    user = "${aws_iam_user.cloudwatch.name}"
    policy = "${file("../../policies/cloudwatch_user_policy.json")}"
}


resource "aws_iam_instance_profile" "cloudwatch" {
    name = "cloudwatch"
    roles = ["${aws_iam_role.cloudwatch.name}"]
}