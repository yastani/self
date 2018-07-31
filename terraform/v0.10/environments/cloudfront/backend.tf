terraform {
  backend "s3" {
    bucket  = "terraform-states"
    key     = "cloudfront/terraform.tfstate"
    region  = "ap-northeast-1"
    profile = "stage"
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"

  config {
    bucket  = "terraform-states"
    key     = "env:/${terraform.workspace}/vpc/terraform.tfstate"
    region  = "ap-northeast-1"
    profile = "stage"
  }
}

data "terraform_remote_state" "ec2" {
  backend = "s3"

  config {
    bucket  = "terraform-states"
    key     = "env:/${terraform.workspace}/ec2/terraform.tfstate"
    region  = "ap-northeast-1"
    profile = "stage"
  }
}
