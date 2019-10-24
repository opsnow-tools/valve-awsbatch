# main
terraform {
  backend "s3" {
    region = "ap-northeast-2"
    bucket = "seoul-sre-batch-state"
    key    = "batch-to-alertnow.tfstate"
  }
}

provider "aws" {
  region = "ap-northeast-2"
}

module "valve" {
  source = "../../modules/batch-to-alertnow"

  # common value
  region = "ap-northeast-2"
  city = "seoul"
  stage = "batch"
  name = "bo"
}