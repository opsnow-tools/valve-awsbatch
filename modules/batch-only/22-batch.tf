# batch.tf

## locals
locals {
  batch_compute_name = "${local.upper_full_name}-COMPUTE"
  batch_queue_name = "${local.upper_full_name}-QUEUE"
  instance_type = "c4.large"
}

resource "aws_batch_compute_environment" "batch_compute" {
  compute_environment_name = "${local.batch_compute_name}"

  compute_resources {
    instance_role = "${aws_iam_instance_profile.ecs_instance_role.arn}"

    instance_type = [
      "${local.instance_type}",
    ]

    max_vcpus = 16
    min_vcpus = 0

    security_group_ids = [
      "${aws_security_group.batch.id}",
    ]

    subnets = local.subnets

    type = "EC2"
  }

  service_role = "${aws_iam_role.aws_batch_service_role.arn}"
  type         = "MANAGED"
  depends_on   = ["aws_iam_role_policy_attachment.aws_batch_service_role"]
}

resource "aws_batch_job_queue" "batch_queue" {
  name                 = "${local.batch_queue_name}"
  state                = "ENABLED"
  priority             = 1
  compute_environments = [
    "${aws_batch_compute_environment.batch_compute.arn}"
  ]
}