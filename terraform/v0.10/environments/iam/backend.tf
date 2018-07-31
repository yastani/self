terraform {
  backend "s3" {
    bucket  = "fencer-terraform-states"
    key     = "iam/terraform.tfstate"
    region  = "ap-northeast-1"
    profile = "fencer-stage"
  }
}
