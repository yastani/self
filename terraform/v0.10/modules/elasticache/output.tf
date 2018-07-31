output "elasticache" {
  value = "${
    map(
      "redis_internal_dns", "${aws_route53_record.redis.name}",
      "redis", "${aws_elasticache_replication_group.redis_replication_group.id}"
    )
  }"
}
