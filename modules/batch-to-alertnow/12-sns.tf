# When creating SNS >>>
/*
locals{
  alertnow_alerts_endpoint = "https://alertnowitgr.opsnow.com/integration/cloudwatch/v1/1c9b2fab9ce09311e979d97702b9b24a415e"
}

resource "aws_sns_topic" "alarms" {
  name = "${local.upper_cluster_name}-ALARMS"
}
resource "aws_sns_topic_subscription" "cloudwatch_alarms" {
  count = "${local.alertnow_alerts_endpoint != "" ? 1 : 0}"

  endpoint               = "${local.alertnow_alerts_endpoint}"
  endpoint_auto_confirms = true
  protocol               = "https"
  topic_arn              = "${aws_sns_topic.alarms.arn}"
}
*/
# <<< End

# When using existing SNS >>>
locals{
  topic_name = "SEOUL-SRE-MIXED-EKS-ALARMS"
}

data "aws_sns_topic" "alarms" {
  name = "${local.topic_name}"
}
# End <<<