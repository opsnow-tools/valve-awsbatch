# locals.tf

## locals
locals {
  
  // Name
  name       = "${var.stage}-${var.name}"
  upper_name = upper(local.name)
  lower_name = lower(local.name)
  full_name  = "${var.city}-${var.stage}-${var.name}"
  upper_full_name = upper(local.full_name)
  lower_full_name = lower(local.full_name)

}

