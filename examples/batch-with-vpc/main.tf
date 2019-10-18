# main

terraform {
  backend "s3" {
    region = "ap-northeast-2"
    bucket = "seoul-sre-batch-state"
    key    = "batch-with-vpc.tfstate"
  }
}

provider "aws" {
  region = "ap-northeast-2"
}

module "valve-awsbatch" {
  source = "../../modules/batch-with-vpc"

  # common value
  region = "ap-northeast-2"
  city = "seoul"
  stage = "batch"
  name = "bwv"
}

# output common
// output "vpc_id" {
//   value = module.valve.vpc_id
// }

// output "vpc_cidr" {
//   value = module.valve.vpc_cidr
// }

// output "subnet_id" {
//   value = module.valve.subnet_id
// }
