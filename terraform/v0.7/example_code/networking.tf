resource "aws_vpc" "adminVPC" {
	cidr_block 						= "${var.vpc_cidr}"
	instance_tenancy 			= "default"
	enable_dns_support 		= "true"
	enable_dns_hostnames 	= "true"
	tags {
		Name = "adminVPC"
	}
}


resource "aws_vpc_dhcp_options" "dns_resolver" {
	domain_name_servers = ["8.8.8.8", "8.8.4.4"]
}


resource "aws_internet_gateway" "adminGW" {
	vpc_id = "${aws_vpc.adminVPC.id}"
}


resource "aws_subnet" "public-a" {
	vpc_id 							= "${aws_vpc.adminVPC.id}"
	cidr_block 					= "${var.vpc_cidr}"
	availability_zone 	= "ap-northeast-1a"
}


resource "aws_route_table" "public-route" {
	vpc_id 							= "${aws_vpc.adminVPC.id}"
	route 							= {
		cidr_block = "0.0.0.0/0"
		gateway_id = "${aws_internet_gateway.adminGW.id}"
	}
}


resource "aws_route_table_association" "public-a" {
	subnet_id 					= "${aws_subnet.public-a.id}"
	route_table_id 			= "${aws_route_table.public-route.id}"
}


resource "aws_security_group" "admin" {
	name 								= "admin"
	description 				= "Allow SSH inbound traffic"
	vpc_id 							= "${aws_vpc.adminVPC.id}"
	ingress {
		from_port 	= 22
		to_port 		= 22
		protocol 		= "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	ingress {
		from_port 	= 80
		to_port 		= 80
		protocol 		= "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	egress {
		from_port 	= 0
		to_port 		= 0
		protocol 		= "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}
}