# batch.tf

## locals
locals {
  compute_env_name = "${local.upper_full_name}"
  instance_type = "c4.large"
}

resource "aws_batch_compute_environment" "compute_env" {
  compute_environment_name = "${local.compute_env_name}"

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

    subnets = [
      "${aws_subnet.private_A.id}",
      "${aws_subnet.private_B.id}",
      "${aws_subnet.private_C.id}",
    ]

    type = "EC2"
  }

  service_role = "${aws_iam_role.aws_batch_service_role.arn}"
  type         = "MANAGED"
  depends_on   = ["aws_iam_role_policy_attachment.aws_batch_service_role"]
}