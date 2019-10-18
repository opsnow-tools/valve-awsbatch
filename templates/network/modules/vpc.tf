# vpc.tf

/* 
  update cidr_block
*/
locals {
  vpc_cidr_block = "10.253.0.0/16"
}

# vpc
resource "aws_vpc" "this" {
  cidr_block           = "${local.vpc_cidr_block}"
  enable_dns_hostnames = true
  tags = merge(
    {
      "Name" = local.upper_name
    }
  )
}
