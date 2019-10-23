resource "aws_cloudwatch_event_rule" "batch-log" {
  name        = "${local.upper_full_name}-BATCH-LOG"
  description = "Capture each Job Log"

  event_pattern = <<PATTERN
{
  "source": [
    "aws.batch"
  ],
  "detail-type": [
    "Batch Job State Change"
  ]
}
PATTERN
}

resource "aws_cloudwatch_log_group" "batch-log" {
  name = "/aws/events/${local.lower_full_name}-batch-log"
}

resource "aws_cloudwatch_event_target" "batch-log" {
  rule      = "${aws_cloudwatch_event_rule.batch-log.name}"
  arn       = "${aws_cloudwatch_log_group.batch-log.arn}"
}