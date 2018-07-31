#--------------------------------------------------------------
# Redis Subnet Group
#--------------------------------------------------------------
resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name = "${lookup(var.prefix, "${terraform.workspace}.prefix")}redis-subnet-group"

  subnet_ids = [
    "${split(",",lookup(var.subnet, "data_subnet_ids"))}",
  ]
}
