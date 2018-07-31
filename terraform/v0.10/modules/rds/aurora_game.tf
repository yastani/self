#--------------------------------------------------------------
# RDS Cluster
#--------------------------------------------------------------
resource "aws_rds_cluster" "cluster" {
  port                            = 3306
  skip_final_snapshot             = "${terraform.workspace == "prod" || terraform.workspace == "stage1" ? true : false}"
  cluster_identifier              = "${lookup(var.prefix, "${terraform.workspace}.prefix")}"
  master_username                 = "${lookup(var.rds, "default.username")}"
  master_password                 = "${var.rds_master_password}"
  db_subnet_group_name            = "${aws_db_subnet_group.main_subnet_group.name}"
  db_cluster_parameter_group_name = "${lookup(var.prefix, "${terraform.workspace}.prefix")}aurora-cluster"
  backup_retention_period         = "${terraform.workspace == "prod" || terraform.workspace == "stage" ? lookup(var.rds, "prod.game_backup_retention_period") : lookup(var.rds, "default.game_backup_retention_period")}"
  preferred_backup_window         = "${lookup(var.rds, "default.preferred_backup_window")}"
  preferred_maintenance_window    = "${lookup(var.rds, "default.preferred_maintenance_window")}"
  apply_immediately               = true

  vpc_security_group_ids = [
    "${aws_security_group.aurora_sg.id}",
  ]
}

#--------------------------------------------------------------
# RDS Cluster Instance
#--------------------------------------------------------------
resource "aws_rds_cluster_instance" "cluster_instance" {
  publicly_accessible          = false
  promotion_tier               = 1
  count                        = "${lookup(var.rds, "${terraform.workspace}.count")}"
  cluster_identifier           = "${aws_rds_cluster.cluster.id}"
  identifier                   = "${aws_rds_cluster.cluster.cluster_identifier}-${format("%03d", count.index + 1)}"
  instance_class               = "${lookup(var.rds, "${terraform.workspace}.instance_class")}"
  db_parameter_group_name      = "${lookup(var.prefix, "${terraform.workspace}.prefix")}aurora-instance"
  preferred_maintenance_window = "${lookup(var.rds, "default.preferred_maintenance_window")}"
  monitoring_interval          = 60
  monitoring_role_arn          = "${var.rds_monitoring_role_arn}"
  auto_minor_version_upgrade   = false
  apply_immediately            = true

  tags {
    Datadog = "${terraform.workspace == "prod" ? "monitored" : ""}"
  }

  tags {
    Environment = "${terraform.workspace}"
  }
}
