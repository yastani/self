variable "key" {
  type = "map"

  default = {
    default.credentials_profile   = "fencer-stage"
    techcross.credentials_profile = "techcross"
    prod.credentials_profile      = "fencer-prod"
  }
}

variable "region" {
  type = "map"

  default = {
    default.region = "ap-northeast-1"
  }
}
