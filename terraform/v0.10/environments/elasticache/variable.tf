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
  }
}

#--------------------------------------------------------------
# Common - Prefix
# Elasticacheでは20文字の文字数制限がある
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
    # private

    ## local
    ### prod
    prod.zone_id = "ZXXXXX"

    ### stage
    stage.zone_id = "ZXXXXX"
  }
}

#--------------------------------------------------------------
# Elasticache
#--------------------------------------------------------------
variable "elasticache" {
  type = "map"

  default = {
    #--------------------------------------------------------------
    # cluster count
    #--------------------------------------------------------------
    prod.default_cluster_count = 2

    stage.default_cluster_count    = 4

    #--------------------------------------------------------------
    # node type for default
    #--------------------------------------------------------------
    prod.default_node_type = "cache.r4.large"

    stage.default_node_type    = "cache.r4.large"

    #--------------------------------------------------------------
    # engine version
    #--------------------------------------------------------------
    default.default_engine_version = "3.2.10"

    #--------------------------------------------------------------
    # maintenance window
    # UTC
    #--------------------------------------------------------------
    default.default_maintenance_window = "Mon:05:00-Mon:08:00"

    #--------------------------------------------------------------
    # cache cluster num
    #--------------------------------------------------------------
    prod.default_cache_cluster_num = 2

    stage.default_cache_cluster_num    = 2

    #--------------------------------------------------------------
    # snapshot retention limit
    #--------------------------------------------------------------
    prod.default_snapshot_retention_limit = 7

    default.default_snapshot_retention_limit = 0
  }
}

#--------------------------------------------------------------
# Elasticache - Parameter Group
#--------------------------------------------------------------
variable "parameter_group" {
  type = "map"

  default = {
    #--------------------------------------------------------------
    # redis family
    #--------------------------------------------------------------
    default.main_param_redis_family = "redis3.2"
  }
}

#--------------------------------------------------------------
# Allow IPAddrs
#--------------------------------------------------------------
variable "all_ip_addrs" {
  default = "0.0.0.0/0"
}

variable "class_a_ip_addrs" {
  default = "10.0.0.0/8"
}
