#--------------------------------------------------------------
# Redis Replication Group of default
#--------------------------------------------------------------
resource "aws_elasticache_replication_group" "redis_default_replication_group" {
  port              = 6379
  subnet_group_name = "${aws_elasticache_subnet_group.redis_subnet_group.name}"

  parameter_group_name          = "${aws_elasticache_parameter_group.redis_main_param_group.name}"
  replication_group_id          = "${lookup(var.prefix, "${terraform.workspace}.prefix")}-${count.index + 1}"
  replication_group_description = "${lookup(var.prefix, "${terraform.workspace}.prefix")}-${count.index + 1}"
  count                         = "${lookup(var.elasticache, "${terraform.workspace}.cluster_count")}"
  number_cache_clusters         = "${lookup(var.elasticache, "${terraform.workspace}.cache_cluster_num")}"
  node_type                     = "${lookup(var.elasticache, "${terraform.workspace}.node_type")}"
  engine                        = "redis"
  engine_version                = "${lookup(var.elasticache, "default.default_engine_version")}"
  maintenance_window            = "${lookup(var.elasticache, "default.default_maintenance_window")}"
  snapshot_retention_limit      = "${terraform.workspace == "prod" || terraform.workspace == "stage" ? lookup(var.elasticache, "prod.default_snapshot_retention_limit") : lookup(var.elasticache, "default.default_snapshot_retention_limit")}"
  automatic_failover_enabled    = "${terraform.workspace == "prod" || terraform.workspace == "stress" || terraform.workspace == "stage" ? true : false}"
  apply_immediately             = true

  security_group_ids = [
    "${aws_security_group.redis_sg.id}",
  ]

  tags {
    Datadog = "${terraform.workspace == "prod" ? "monitored" : ""}"
  }

  tags {
    Environment = "${terraform.workspace}"
  }
}
