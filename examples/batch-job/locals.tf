# locals.tf

## locals
locals {
  // Name
  city       = "seoul"
  stage      = "batch"
  name       = "${local.stage}-bo"
  upper_name = upper(local.name)
  lower_name = lower(local.name)
  full_name  = "${local.city}-${local.name}"
  upper_full_name = upper(local.full_name)
}

