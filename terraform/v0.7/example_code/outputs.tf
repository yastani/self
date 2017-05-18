output "public_ip of WebApp" {
    value = "${aws_instance.webapp.public_ip}"
}


output "public_ip of Bastion" {
    value = "${aws_instance.bastion.public_ip}"
}


#output "database endpoint of db_t2_micro" {
#	value = "${aws_db_instance.db_t2_micro.endpoint}"
#}