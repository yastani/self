#####################################
# Provider Settings
#####################################
provider "aws" {
  region  = "${lookup(var.region, "default.region")}"
  profile = "${lookup(var.key, "${terraform.workspace}.credentials_profile")}"
}

provider "aws" {
  alias   = "hoge"
  region  = "${lookup(var.region, "default.region")}"
  profile = "${lookup(var.key, "default.credentials_profile")}"
}
