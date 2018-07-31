terraform {
  backend "s3" {
    bucket  = "terraform-states"
    key     = "vpc/terraform.tfstate"
    region  = "ap-northeast-1"
    profile = "stage"
  }
}
