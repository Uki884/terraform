#####################################
# Security Group Settings
#####################################

#ALB
resource "aws_security_group" "alb_sg" {
    name = "${var.app_name}-alb-sg"
    vpc_id = "${aws_vpc.vpc_main.id}"
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
        ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    description = "${var.app_name}-alb-sg"
}
#WEB
resource "aws_security_group" "web_sg" {
    name = "${var.app_name}-web-sg"
    vpc_id = "${aws_vpc.vpc_main.id}"
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        security_groups = ["${aws_security_group.alb_sg.id}"]
    }
        ingress {
        from_port = 9100
        to_port = 9100
        protocol = "tcp"
        cidr_blocks = ["52.68.146.7/32"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["${var.ssh_allow_ip}"]
        # cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    description = "${var.app_name}-web-sg"
}
# RDS
resource "aws_security_group" "rds_sg" {
    name = "${var.app_name}-rds-sg"
    vpc_id = "${aws_vpc.vpc_main.id}"
    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        security_groups = ["${aws_security_group.web_sg.id}"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    description = "${var.app_name}-rds-sg"
}
# EFS
resource "aws_security_group" "efs_sg" {
    name = "${var.app_name}-efs-sg"
    vpc_id = "${aws_vpc.vpc_main.id}"
    ingress {
        from_port = 2049
        to_port = 2049
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    description = "${var.app_name}-efs-sg"
}