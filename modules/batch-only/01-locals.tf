# locals.tf

## locals
data "aws_availability_zones" "azs" {
}

locals {
  
  // Name
  name       = "${var.stage}-${var.name}"
  upper_name = upper(local.name)
  lower_name = lower(local.name)
  full_name  = "${var.city}-${var.stage}-${var.name}"
  upper_full_name = upper(local.full_name)
  lower_full_name = lower(local.full_name)

  // Availability Zone
  az_name_A  = upper("${var.city}-A-${var.stage}-${var.name}")
  az_name_B  = upper("${var.city}-B-${var.stage}-${var.name}")
  az_name_C  = upper("${var.city}-C-${var.stage}-${var.name}")

  az_names   = data.aws_availability_zones.azs.names
  az_length  = length(local.az_names[0])

  vpc_id = "vpc-74755b1c"
  subnets = [
      "subnet-f628079e",
      "subnet-9125b6dd",
      "subnet-45d5093e",
    ]

}

