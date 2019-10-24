
resource "aws_cloudwatch_metric_alarm" "batch_failure" {
  alarm_name = "${local.upper_full_name}-BATCH-JobFailure"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods = "1"
  metric_name = "IncomingLogEvents"
  namespace = "AWS/Logs"
  period = "60"
  statistic = "Sum"
  threshold = "0"

  dimensions = {
    LogGroupName = "${aws_cloudwatch_log_group.batch-failure-log.name}"
  }

  alarm_description = "This metric monitors failure of batch jobs."

  # When using existing SNS
  alarm_actions     = ["${data.aws_sns_topic.alarms.arn}"]
  # When creating SNS
  # alarm_actions     = ["${aws_sns_topic.alarms.arn}"]
}