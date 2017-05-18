#resource "aws_cloudwatch_event_rule" "send_to_sns" {
#    rule = "${aws_cloudwatch_event_rule.console.name}"
#    target_id = "SendToSNS"
#    arn = "${aws_sns_topic.aws_logins.arn}"
#    is_enabled = true
#}

/*

resource "aws_cloudwatch_metric_alarm" "metric_cpu_util" {
    alarm_name = "CPUUtilization"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods = "5"
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = "60"
    statistic = "Maximum"
    threshold = "60"
    alarm_description = "Its very high CPU-Load:${aws_instance.vm_t2_micro.tags.Name}"
    insufficient_data_actions = []
    alarm_actions = [
        "${aws_sns_topic.notify_to_slack.arn}"
    ]
    dimensions {
        InstanceId = "${aws_instance.vm_t2_micro.id}"
    }
}


resource "aws_cloudwatch_metric_alarm" "metric_status_check_failed" {
    alarm_name = "StatusCheckFailed"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods = "5"
    metric_name = "StatusCheckFailed"
    namespace = "AWS/EC2"
    period = "60"
    statistic = "Average"
    threshold = "1"
    alarm_description = "Its status check failed:${aws_instance.vm_t2_micro.tags.Name}"
    insufficient_data_actions = []
    alarm_actions = [
        "${aws_sns_topic.notify_to_slack.arn}"
    ]
    dimensions {
        InstanceId = "${aws_instance.vm_t2_micro.id}"
    }
}


resource "aws_cloudwatch_metric_alarm" "metric_mem_util" {
    alarm_name = "MemoryUtilization"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods = "5"
    metric_name = "MemoryUtilization"
    namespace = "System/Linux"
    period = "60"
    statistic = "Maximum"
    threshold = "60"
    alarm_description = "Its very high Memory:${aws_instance.vm_t2_micro.tags.Name}"
    insufficient_data_actions = []
    alarm_actions = [
        "${aws_sns_topic.notify_to_slack.arn}"
    ]
    dimensions {
        InstanceId = "${aws_instance.vm_t2_micro.id}"
    }
}


# 2016/08/18 Ubuntu14ではDiskUtilがCloudwatchで取得できないため一旦保留

resource "aws_cloudwatch_metric_alarm" "metric_diskspace_util" {
    alarm_name = "DiskSpaceUtilization"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods = "5"
    metric_name = "DiskSpaceUtilization"
    namespace = "System/Linux"
    period = "60"
    statistic = "Average"
    threshold = "70"
    alarm_description = "Its very high diskspace percentage:${aws_instance.vm_t2_micro.tags.Name}"
    insufficient_data_actions = []
    alarm_actions = [
        "${aws_sns_topic.notify_to_slack.arn}"
    ]
    dimensions {
        InstanceId = "${aws_instance.vm_t2_micro.id}"
        FileSystem = "/dev/disk/by-uuid/736fad7a-387f-4420-b934-4ccbafa26d16"
        MountPath = "/"
    }
    unit = "Percent"
}


resource "aws_cloudwatch_metric_alarm" "metric_http_status_fail" {
    alarm_name = "HttpStatusFail"
    comparison_operator = "GreaterThanThreshold"
    evaluation_periods = "5"
    metric_name = "HttpStatusFail"
    namespace = "System/Linux"
    period = "60"
    statistic = "Maximum"
    threshold = "0"
    alarm_description = "Its http status fail error:${aws_instance.vm_t2_micro.tags.Name}"
    insufficient_data_actions = [
        "${aws_sns_topic.notify_to_slack.arn}"
    ]
    alarm_actions = [
        "${aws_sns_topic.notify_to_slack.arn}"
    ]
    dimensions {
        InstanceId = "${aws_instance.vm_t2_micro.id}"
        MonitorUrl = "${var.monitor_url}"
        HttpStatusCode = "200"
    }
}

*/