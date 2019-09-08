#####################################
# RDS Settings
#####################################

#サブネットグループ
resource "aws_db_subnet_group" "default" {
    name = "${var.app_name}-rds-subnet"
    description = "${var.app_name} MultiAZ"
    subnet_ids = ["${aws_subnet.vpc_main-private-subnet1.id}", "${aws_subnet.vpc_main-private-subnet2.id}"]
}
#インスタンス作成
resource "aws_db_instance" "default" {
  identifier = "${var.db_name}"
  allocated_storage = 20
  engine = "mysql"
  engine_version = "5.7.22"
  instance_class = "db.t2.micro"
  storage_type = "gp2"
  username = "root"
  password = "${var.db_password}"
  maintenance_window = "Mon:19:00-Mon:20:00"
  backup_window = "17:00-18:00"
  backup_retention_period = "7"
  vpc_security_group_ids = ["${aws_security_group.rds_sg.id}"]
  db_subnet_group_name = "${aws_db_subnet_group.default.id}"
  publicly_accessible = true
}

#パラメータグループ
resource "aws_db_parameter_group" "default" {
    name = "rds-pg"
    family = "mysql5.7"
    description = "Managed by Terraform"

    parameter {
      name = "time_zone"
      value = "Asia/Tokyo"
    }
}