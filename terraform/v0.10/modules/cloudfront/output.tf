output "cloudfront" {
  value = "${
    map(
      "cloudfront_distribution_id", "${aws_cloudfront_distribution.main.id}"
    )
  }"
}
