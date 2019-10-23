resource "aws_cloudwatch_event_rule" "batch-failure" {
  name        = "${local.upper_full_name}-JOB-FAILURE"
  description = "Capture each Sample Job Failure"

  event_pattern = <<PATTERN
{
  "source": [
    "aws.batch"
  ],
  "detail-type": [
    "Batch Job State Change"
  ],
  "detail": {
    "status": [
      "FAILED"
    ]
  }
}
PATTERN
}

resource "aws_cloudwatch_log_group" "batch-failure-log" {
  name = "/aws/events/${local.lower_full_name}-batch-failure"
}

resource "aws_cloudwatch_event_target" "batch-failure-log" {
  rule      = "${aws_cloudwatch_event_rule.batch-failure.name}"
  arn       = "${aws_cloudwatch_log_group.batch-failure-log.arn}"
}