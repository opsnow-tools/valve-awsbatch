# security-group.tf

## cluster security group
resource "aws_security_group" "batch" {
  name        = "${local.upper_full_name}-BATCH"
  description = "Security group for batch worker nodes"

  vpc_id = "${local.vpc_id}"

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}
