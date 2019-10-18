# security-group.tf

locals {
  vpc_id    = "${aws_vpc.this.id}"
}

## cluster security group
resource "aws_security_group" "batch" {
  name        = "${local.upper_full_name}-BATCH"
  description = "Security group for batch worker nodes"

  vpc_id = "${local.vpc_id}"
}
