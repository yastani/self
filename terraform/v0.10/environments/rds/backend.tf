terraform {
  backend "s3" {
    bucket  = "terraform-states"
    key     = "rds/terraform.tfstate"
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

data "aws_iam_role" "rds_monitoring_role" {
  name = "rds-monitoring-role"
}

data "aws_kms_secret" "rds" {
  count = "${terraform.workspace == "prod" ? 1 : 0}"

  "secret" {
    name    = "master_password"
    payload = "AQICAHggZ2x/By4W986WWyTTfKhhzAg1Fy4RuKIn7GuuOSZX6QGiml/UBxLbn0K20+K6hWLrAAAAajBoBgkqhkiG9w0BBwagWzBZAgEAMFQGCSqGSIb3DQEHATAeBglghkgBZQMEAS4wEQQMH3DGtkxFkZgG50/cAgEQgCfNhNTLp5ret8dJjUTTPmdgzc2YppWVlcu1x4pqQuB/fviU8J/J3m4="
  }
}
