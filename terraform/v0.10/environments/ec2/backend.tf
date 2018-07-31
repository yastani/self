terraform {
  backend "s3" {
    bucket  = "terraform-states"
    key     = "ec2/terraform.tfstate"
    region  = "ap-northeast-1"
    profile = "default"
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"

  config {
    bucket  = "terraform-states"
    key     = "env:/${terraform.workspace}/vpc/terraform.tfstate"
    region  = "ap-northeast-1"
    profile = "default"
  }
}

data "terraform_remote_state" "prod_iam" {
  backend = "s3"

  config {
    bucket  = "terraform-states"
    key     = "env:/prod/iam/terraform.tfstate"
    region  = "ap-northeast-1"
    profile = "stage"
  }
}

data "terraform_remote_state" "stage_iam" {
  backend = "s3"

  config {
    bucket  = "terraform-states"
    key     = "env:/stage/iam/terraform.tfstate"
    region  = "ap-northeast-1"
    profile = "stage"
  }
}
