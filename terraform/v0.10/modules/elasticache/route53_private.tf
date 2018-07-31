#--------------------------------------------------------------
# Route53 for redis Internal DNS
#--------------------------------------------------------------
resource "aws_route53_record" "redis" {
  count   = "${lookup(var.elasticache, "${terraform.workspace}.cluster_count")}"
  zone_id = "${lookup(var.route53, "${terraform.workspace}.zone_id")}"
  name    = "${format("redis-def-%03d", count.index + 1)}.local"
  type    = "CNAME"
  ttl     = 60

  records = [
    "${element(aws_elasticache_replication_group.redis_default_replication_group.*.primary_endpoint_address, count.index)}",
  ]

  depends_on = [
    "aws_elasticache_replication_group.redis_replication_group",
  ]
}
