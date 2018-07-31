#####################################
# Provider Settings
#####################################
provider "aws" {
  region  = "${lookup(var.region, "default.region")}"
  profile = "${lookup(var.key, "${terraform.workspace}.credentials_profile")}"
}

provider "aws" {
  alias   = "default"
  region  = "${lookup(var.region, "default.region")}"
  profile = "${lookup(var.key, "default.credentials_profile")}"
}

#####################################
# Provider Settings
#####################################
provider "aws" {
  alias   = "prod.us-east-1"
  region  = "${lookup(var.region, "cloudfront.region")}"
  profile = "${lookup(var.key, "prod.credentials_profile")}"
}

provider "aws" {
  alias   = "stage.us-east-1"
  region  = "${lookup(var.region, "cloudfront.region")}"
  profile = "${lookup(var.key, "default.credentials_profile")}"
}
