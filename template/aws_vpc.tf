#####################################
# VPC Settings
#####################################
resource "aws_vpc" "vpc_main" {
    enable_dns_hostnames = "enable"
    cidr_block = "${var.root_segment}"
    tags= {
        Name = "${var.app_name}-vpc"
    }
}

#####################################
# Internet Gateway Settings
#####################################
resource "aws_internet_gateway" "vpc_main-igw" {
    vpc_id = "${aws_vpc.vpc_main.id}"
    tags= {
        Name = "${var.app_name}-igw"
    }
}

#####################################
# Public Subnets Settings
#####################################
resource "aws_subnet" "vpc_main-public-subnet1" {
    vpc_id = "${aws_vpc.vpc_main.id}"
    cidr_block = "${var.public_segment1}"
    availability_zone = "${var.public_segment1_az}"
    tags ={
        Name = "${var.app_name}-subnet-public-1a"
    }
}
resource "aws_subnet" "vpc_main-public-subnet2" {
    vpc_id = "${aws_vpc.vpc_main.id}"
    cidr_block = "${var.public_segment2}"
    availability_zone = "${var.public_segment2_az}"
    tags ={
        Name = "${var.app_name}-subnet-public-1c"
    }
}

#####################################
# Private Subnets Settings
#####################################
resource "aws_subnet" "vpc_main-private-subnet1" {
    vpc_id = "${aws_vpc.vpc_main.id}"
    cidr_block = "${var.private_segment1}"
    availability_zone = "${var.private_segment1_az}"
    tags ={
        Name = "${var.app_name}-subnet-private-1a"
    }
}

resource "aws_subnet" "vpc_main-private-subnet2" {
    vpc_id = "${aws_vpc.vpc_main.id}"
    cidr_block = "${var.private_segment2}"
    availability_zone = "${var.private_segment2_az}"
    tags ={
        Name = "${var.app_name}-subnet-private-1c"
    }
}

#####################################
# Routes Table Settings
#####################################
resource "aws_route_table" "vpc_main-public-rt" {
    vpc_id = "${aws_vpc.vpc_main.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.vpc_main-igw.id}"
    }
    tags ={
        Name = "${var.app_name}-route-table-public"
    }
}
# resource "aws_route_table" "vpc_main-private-rt" {
#     vpc_id = "${aws_vpc.vpc_main.id}"
#     route {
#         cidr_block = "${var.root_segment}"
#         gateway_id = "${aws_internet_gateway.vpc_main-igw.id}"
#     }
#     tags ={
#         Name = "${var.app_name}-route-table-private"
#     }
# }
#ルートテーブルとvpcの紐付け
# public
resource "aws_route_table_association" "vpc_main-rta1" {
    subnet_id = "${aws_subnet.vpc_main-public-subnet1.id}"
    route_table_id = "${aws_route_table.vpc_main-public-rt.id}"
}
resource "aws_route_table_association" "vpc_main-rta2" {
    subnet_id = "${aws_subnet.vpc_main-public-subnet2.id}"
    route_table_id = "${aws_route_table.vpc_main-public-rt.id}"
}
# private

# resource "aws_route_table_association" "vpc_main-rta3" {
#     subnet_id = "${aws_subnet.vpc_main-private-subnet1.id}"
#     route_table_id = "${aws_route_table.vpc_main-private-rt.id}"
# }
# resource "aws_route_table_association" "vpc_main-rta4" {
#     subnet_id = "${aws_subnet.vpc_main-private-subnet2.id}"
#     route_table_id = "${aws_route_table.vpc_main-private-rt.id}"
# }