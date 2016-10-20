resource "aws_instance" "bastion" {
    ami                         = "${var.images["CentOS7-1"]}"
    instance_type               = "${var.instance_types["bastion"]}"
    key_name                    = "${var.ec2_keypair_name}"
    iam_instance_profile        = "${aws_iam_instance_profile.cloudwatch.id}"
    count                       = 1
    vpc_security_group_ids      = [
        "${aws_security_group.admin.id}"
    ]
    subnet_id                   = "${aws_subnet.public-a.id}"
    associate_public_ip_address = "true"
    root_block_device           = {
        volume_type = "gp2"
        volume_size = "20"
    }
    ebs_block_device            = {
        device_name = "/dev/sdf"
        volume_type = "gp2"
        volume_size = "100"
    }
    tags {
        Name        = "bastion"
    }
}