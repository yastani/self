#--------------------------------------------------------------
# RDS Cluster Parameter Group
#--------------------------------------------------------------
resource "aws_rds_cluster_parameter_group" "main_cluster_param_group" {
  name        = "${lookup(var.prefix, "${terraform.workspace}.prefix")}aurora-cluster"
  family      = "${lookup(var.parameter_group, "default.db_family")}"
  description = "${lookup(var.prefix, "${terraform.workspace}.prefix")}RDS-Cluster param group"

  parameter {
    name  = "time_zone"
    value = "${lookup(var.parameter_group, "default.timezone")}"
  }
}

#--------------------------------------------------------------
# DB Parameter Group
#--------------------------------------------------------------
resource "aws_db_parameter_group" "main_instance_param_group" {
  name   = "${lookup(var.prefix, "${terraform.workspace}.prefix")}aurora-instance"
  family = "${lookup(var.parameter_group, "default.db_family")}"

  parameter {
    name  = "autocommit"
    value = "${lookup(var.parameter_group, "default.autocommit")}"
  }

  parameter {
    name  = "innodb_lock_wait_timeout"
    value = "${lookup(var.parameter_group, "default.innodb_lock_wait_timeout")}"
  }

  parameter {
    name  = "innodb_print_all_deadlocks"
    value = "${lookup(var.parameter_group, "default.innodb_print_all_deadlocks")}"
  }

  parameter {
    name  = "interactive_timeout"
    value = "${lookup(var.parameter_group, "default.interactive_timeout")}"
  }

  parameter {
    name  = "max_connections"
    value = "${lookup(var.parameter_group, "default.max_connections")}"
  }

  parameter {
    name  = "tx_isolation"
    value = "${lookup(var.parameter_group, "default.tx_isolation")}"
  }

  parameter {
    name  = "connect_timeout"
    value = "${lookup(var.parameter_group, "default.connect_timeout")}"
  }

  parameter {
    name  = "wait_timeout"
    value = "${lookup(var.parameter_group, "default.wait_timeout")}"
  }

  parameter {
    name  = "max_allowed_packet"
    value = "${lookup(var.parameter_group, "default.max_allowed_packet")}"
  }

  parameter {
    name  = "delayed_insert_timeout"
    value = "${lookup(var.parameter_group, "default.delayed_insert_timeout")}"
  }
}
