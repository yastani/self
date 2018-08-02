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
    ## example.com
    hoge.zone_id = "ZXXXXX"

    ## example.net
    prod.zone_id = "ZXXXXX"

    #--------------------------------------------------------------
    # private
    #--------------------------------------------------------------
    ## local
    ### prod
    prod.private.zone_id = "ZXXXXX"

    ### stage
    stage.private.zone_id = "ZXXXXX"
  }
}

#--------------------------------------------------------------
# EC2
#--------------------------------------------------------------
variable "ec2" {
  type = "map"

  default = {
    #--------------------------------------------------------------
    # acm
    #--------------------------------------------------------------
    # example.net
    prod.certificate_arn = "arn:aws:acm:ap-northeast-1:417573262727:certificate/5ba5f68d-5f44-4728-b258-cf3bdab83e25"

    # example.com
    stage.certificate_arn = "arn:aws:acm:ap-northeast-1:417573262727:certificate/3dfc85d9-60ff-4b97-a5ee-896c6c0f3157"

    #--------------------------------------------------------------
    # key pair
    #--------------------------------------------------------------
    prod.key_name = "prod-internal"

    stage.key_name    = "stage-internal-key"

    #--------------------------------------------------------------
    # ami id for admin
    #--------------------------------------------------------------
    prod.admin_server_ami_id = "ami-3b776347"

    stage.admin_server_ami_id    = "ami-dc0f1aa0"

    #--------------------------------------------------------------
    # ami id for batch
    #--------------------------------------------------------------
    prod.batch_server_ami_id = "ami-7770640b"

    stage.batch_server_ami_id    = "ami-710c190d"

    #--------------------------------------------------------------
    # ami id for provision
    #--------------------------------------------------------------
    prod.provision_server_ami_id = "ami-b57165c9"

    stage.provision_server_ami_id    = "ami-f30d188f"

    #--------------------------------------------------------------
    # ami id for web
    #--------------------------------------------------------------
    prod.web_server_ami_id = "ami-3f7c6843"

    stage.web_server_ami_id    = "ami-7702170b"

    #--------------------------------------------------------------
    # server type for admin
    #--------------------------------------------------------------
    prod.admin_server_type = "t2.small"

    stage.admin_server_type    = "t2.medium"

    #--------------------------------------------------------------
    # server type for batch
    #--------------------------------------------------------------
    prod.batch_server_type = "t2.small"

    stage.batch_server_type    = "c4.large"

    #--------------------------------------------------------------
    # server type for provision
    #--------------------------------------------------------------
    prod.provision_server_type = "t2.medium"

    stage.provision_server_type    = "t2.medium"

    #--------------------------------------------------------------
    # server type for web
    #--------------------------------------------------------------
    prod.web_server_type = "t2.medium"

    stage.web_server_type    = "c4.4xlarge"

    #--------------------------------------------------------------
    # server count for admin
    #--------------------------------------------------------------
    default.admin_server_num = 1

    #--------------------------------------------------------------
    # server count for batch
    #--------------------------------------------------------------
    default.batch_server_num = 1

    #--------------------------------------------------------------
    # server count for provision
    #--------------------------------------------------------------
    default.provision_server_num = 1

    #--------------------------------------------------------------
    # server count for web
    #--------------------------------------------------------------
    prod.web_server_num = 2
    prod.web_server_max_num      = 500
    prod.web_server_min_num      = 0

    stage.web_server_num        = 2
    stage.web_server_max_num    = 500
    stage.web_server_min_num    = 0

    #--------------------------------------------------------------
    # load balancer server count
    # web albはTargetGroupではなくAutoscalingGroupで管理しているため
    # target group attachment count が必要ない
    #--------------------------------------------------------------

    #--------------------------------------------------------------
    # web alb count
    #--------------------------------------------------------------
    default.web_alb_count = 1

    #--------------------------------------------------------------
    # admin alb count
    #--------------------------------------------------------------
    default.admin_alb_count = 1

    #--------------------------------------------------------------
    # admin alb target group attachment count
    #--------------------------------------------------------------
    default.admin_alb_target_group_attachment_count = 1

    #--------------------------------------------------------------
    # Tags Internal Domain Name
    #--------------------------------------------------------------
    default.admin_internal_domain_name = "admin.local"
    default.batch_internal_domain_name       = "batch.local"
    default.provision_internal_domain_name   = "provision.local"
    default.web_internal_domain_name   = "web.local"
  }
}

#--------------------------------------------------------------
# Allow IP Addrs
#--------------------------------------------------------------
variable "all_ip_addrs" {
  default = "0.0.0.0/0"
}

variable "class_a_ip_addrs" {
  default = "10.0.0.0/8"
}
