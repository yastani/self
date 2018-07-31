output "rds" {
  value = "${
    map(
      "aurora_internal_dns", "${aws_route53_record.aurora.name}",
      "aurora_writer_endpoint", "${aws_rds_cluster.cluster.endpoint}",
      "aurora_reader_endpoint", "${aws_rds_cluster.cluster.reader_endpoint}"
    )
  }"
}
