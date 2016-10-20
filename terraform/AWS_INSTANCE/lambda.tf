resource "aws_lambda_function" "notify_to_slack" {
    function_name   = "NotifyToSlack"
    role            = "${aws_iam_role.lambda.arn}"
    handler         = "index.handler"
    runtime         = "nodejs4.3"
    s3_bucket       = "lambda-functions-notify-to-slack"
    s3_key          = "notify_to_slack.zip"
    #vpc_config = {
    #    subnet_ids = [
    #        "${aws_subnet.db_subnet_lambda_az1.id}",
    #        "${aws_subnet.db_subnet_lambda_az2.id}"
    #    ]
    #    security_group_ids = [
    #        "${aws_security_group.admin.id}"
    #    ]
    #}        
}

resource "aws_lambda_permission" "with_sns" {
    statement_id    = "AllowExecutionFromSNS"
    action          = "lambda:InvokeFunction"
    function_name   = "${aws_lambda_function.notify_to_slack.arn}"
    principal       = "sns.amazonaws.com"
    source_arn      = "${aws_sns_topic.notify_to_slack.arn}"
}