#--------------------------------------------------------------
# Common - Key
# Terraform 0.10.2 ではproviderでconditionを書けないので一旦この形にしている
#--------------------------------------------------------------
variable "key" {
  type = "map"

  default = {
    # default
    default.credentials_profile = "default"

    # prod
    prod.credentials_profile = "prod"

    # stage
    stage.credentials_profile = "stage"
  }
}

#--------------------------------------------------------------
# Common - Region
#--------------------------------------------------------------
variable "region" {
  type = "map"

  default = {
    # default
    default.region = "ap-northeast-1"

    # use cloudfront
    cloudfront.region = "us-east-1"
  }
}

#--------------------------------------------------------------
# Common - Prefix
#--------------------------------------------------------------
variable "prefix" {
  type = "map"

  default = {
    # prod
    prod.prefix = "prod-"

    # stage
    stage.prefix = "stage-"
  }
}

#--------------------------------------------------------------
# Common - Route53
#--------------------------------------------------------------
variable "route53" {
  type = "map"

  default = {
    #--------------------------------------------------------------
    # public
    #--------------------------------------------------------------
    # example.com
    hoge.zone_id = "ZXXXX"

    # example.net
    prod.zone_id = "ZXXXX"
  }
}

#--------------------------------------------------------------
# Cloudfront
#--------------------------------------------------------------
variable "cloudfront" {
  type = "map"

  default = {
    #--------------------------------------------------------------
    # price class
    #--------------------------------------------------------------
    default.main_price_class = "PriceClass_200"

    #--------------------------------------------------------------
    # aliases
    #--------------------------------------------------------------
    prod.aliases = "example.net"

    stage.aliases    = "example.com"

    #--------------------------------------------------------------
    # web acl id
    #--------------------------------------------------------------
    default.main_web_acl_id = "bf79cf9f-2dbe-4ccd-9994-52744bf11d2d"

    prod.main_web_acl_id = "7816a943-354c-4e0c-bcf0-bb8fc1f2e2f1"
  }
}

#--------------------------------------------------------------
# Cloudfront - Origin
#--------------------------------------------------------------
variable "origin" {
  type = "map"

  default = {
    #--------------------------------------------------------------
    # S3 Origin - http port
    #--------------------------------------------------------------
    default.main_s3_origin_http_port = 80

    #--------------------------------------------------------------
    # S3 Origin - https port
    #--------------------------------------------------------------
    default.main_s3_origin_https_port = 443

    #--------------------------------------------------------------
    # S3 Origin - origin protocol policy
    #--------------------------------------------------------------
    default.main_s3_origin_origin_protocol_policy = "match-viewer"

    #--------------------------------------------------------------
    # Custom Origin - http port
    #--------------------------------------------------------------
    default.main_custom_origin_http_port = 80

    #--------------------------------------------------------------
    # Custom Origin - https port
    #--------------------------------------------------------------
    default.main_custom_origin_https_port = 443

    #--------------------------------------------------------------
    # Custom Origin - origin keepalive timeout
    #--------------------------------------------------------------
    default.main_custom_origin_origin_keepalive_timeout = 5

    #--------------------------------------------------------------
    # Custom Origin - origin protocol policy
    #--------------------------------------------------------------
    default.main_custom_origin_origin_protocol_policy = "http-only"

    #--------------------------------------------------------------
    # Custom Origin - origin read timeout
    #--------------------------------------------------------------
    prod.main_custom_origin_origin_read_timeout = 30

    stage.main_custom_origin_origin_read_timeout    = 30
  }
}

#--------------------------------------------------------------
# Cloudfront - Behavior
#--------------------------------------------------------------
variable "behivior" {
  type = "map"

  default = {
    #--------------------------------------------------------------
    # Default Cache Behavior - viewer protocol policy
    #--------------------------------------------------------------
    default.main_default_cache_behavior_viewer_protocol_policy = "allow-all"

    #--------------------------------------------------------------
    # Default Cache Behavior - min ttl
    # * default value -> 0
    #--------------------------------------------------------------
    prod.main_default_cache_behavior_min_ttl = 0

    default.main_default_cache_behavior_min_ttl = 0

    #--------------------------------------------------------------
    # Default Cache Behavior - default ttl
    # * default value -> 86400
    #--------------------------------------------------------------
    prod.main_default_cache_behavior_default_ttl = 86400

    default.main_default_cache_behavior_default_ttl = 86400

    #--------------------------------------------------------------
    # Default Cache Behavior - max ttl
    # * default value -> 31536000
    #--------------------------------------------------------------
    prod.main_default_cache_behavior_max_ttl = 31536000

    default.main_default_cache_behavior_max_ttl = 31536000

    #--------------------------------------------------------------
    # Default Cache Behavior - query string
    #--------------------------------------------------------------
    default.main_forwarded_values_query_string = true

    #--------------------------------------------------------------
    # Default Cache Behavior - geo restriction type
    #--------------------------------------------------------------
    default.main_geo_restriction_restriction_type = "none"

    #--------------------------------------------------------------
    # Default Cache Behavior - default certificate
    #--------------------------------------------------------------
    default.main_viewer_certificate_cloudfront_default_certificate = false

    #--------------------------------------------------------------
    # Default Cache Behavior - iam certificate id
    #--------------------------------------------------------------
    prod.main_viewer_certificate_acm_certificate_arn = "arn:aws:acm:us-east-1:417573262727:certificate/23491db8-41c3-452b-87d5-825cad2f925d"

    stage.main_viewer_certificate_acm_certificate_arn    = "arn:aws:acm:us-east-1:518393472935:certificate/7343cf9e-0e28-4b55-9149-a79bfad0fd4e"

    #--------------------------------------------------------------
    # Default Cache Behavior - ssl support method
    #--------------------------------------------------------------
    default.main_viewer_certificate_ssl_support_method = "sni-only"

    #--------------------------------------------------------------
    # Default Cache Behavior - minimum protocol version
    #--------------------------------------------------------------
    default.main_viewer_certificate_minimum_protocol_version = "TLSv1"
  }
}
