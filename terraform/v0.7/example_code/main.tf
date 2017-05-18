provider "aws" {
  shared_credentials_file = "${var.shared_credentials_file_path}"
  region                  = "${var.region}"
  profile                 = "${var.name}"
}

