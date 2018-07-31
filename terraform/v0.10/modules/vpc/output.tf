output "vpc" {
  value = "${
    map(
      "vpc_id",   "${aws_vpc.vpc.id}",
      "vpc_cidr", "${aws_vpc.vpc.cidr_block}"
    )
  }"
}

output "subnet" {
  value = "${
    map(
      "pub_subnet_ids",    "${aws_subnet.pub_subnet_a.id},${aws_subnet.pub_subnet_d.id}",
      "web_subnet_ids",    "${aws_subnet.web_subnet_a.id},${aws_subnet.web_subnet_c.id}.${aws_subnet.web_subnet_d.id}",
      "pubsub_subnet_ids", "${aws_subnet.pubsub_subnet_a.id},${aws_subnet.pubsub_subnet_c.id},${aws_subnet.pubsub_subnet_d.id}",
      "data_subnet_ids",   "${aws_subnet.data_subnet_a.id},${aws_subnet.data_subnet_c.id},${aws_subnet.data_subnet_d.id}",
      "lb_subnet_ids",     "${aws_subnet.lb_subnet_a.id},${aws_subnet.lb_subnet_c.id},${aws_subnet.lb_subnet_d.id}",

      "pub_subnet_a_cidr_block", "${aws_subnet.pub_subnet_a.cidr_block}",
      "pub_subnet_d_cidr_block", "${aws_subnet.pub_subnet_d.cidr_block}",

      "lb_subnet_a_cidr_block", "${aws_subnet.lb_subnet_a.cidr_block}",
      "lb_subnet_c_cidr_block", "${aws_subnet.lb_subnet_c.cidr_block}",
      "lb_subnet_d_cidr_block", "${aws_subnet.lb_subnet_d.cidr_block}",

      "web_subnet_a_cidr_block", "${aws_subnet.web_subnet_a.cidr_block}",
      "web_subnet_c_cidr_block", "${aws_subnet.web_subnet_c.cidr_block}",
      "web_subnet_d_cidr_block", "${aws_subnet.web_subnet_d.cidr_block}",

      "pubsub_subnet_a_cidr_block", "${aws_subnet.pubsub_subnet_a.cidr_block}",
      "pubsub_subnet_c_cidr_block", "${aws_subnet.pubsub_subnet_c.cidr_block}",
      "pubsub_subnet_d_cidr_block", "${aws_subnet.pubsub_subnet_d.cidr_block}",

      "data_subnet_a_cidr_block", "${aws_subnet.data_subnet_a.cidr_block}",
      "data_subnet_c_cidr_block", "${aws_subnet.data_subnet_c.cidr_block}",
      "data_subnet_d_cidr_block", "${aws_subnet.data_subnet_d.cidr_block}"
    )
  }"
}
