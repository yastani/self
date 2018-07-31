#--------------------------------------------------------------
# DB Subnet Group
#--------------------------------------------------------------
resource "aws_db_subnet_group" "main_subnet_group" {
  name = "${lookup(var.prefix, "${terraform.workspace}.prefix")}db-subnet-group"

  subnet_ids = [
    "${split(",",lookup(var.subnet, "data_subnet_ids"))}",
  ]
}
