#--------------------------------------------------------------
# Redis Parameter Group
#--------------------------------------------------------------
resource "aws_elasticache_parameter_group" "redis_param_group" {
  name   = "${lookup(var.prefix, "${terraform.workspace}.prefix")}redis-params"
  family = "${lookup(var.parameter_group, "default.param_redis_family")}"
}
