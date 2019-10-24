# main
terraform {
  backend "s3" {
    region = "ap-northeast-2"
    bucket = "seoul-sre-batch-state"
    key    = "batch-job.tfstate"
  }
}

provider "aws" {
  region = "ap-northeast-2"
}

