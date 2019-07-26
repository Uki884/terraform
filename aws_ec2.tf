#インスタンス作成
resource "aws_instance" "ec2" {
  count         = 1
  ami           = "ami-785c491f" # Ubuntu 16.04 LTS official ami
  instance_type = "t2.micro"
  root_block_device {
    volume_type = "${var.ebs_root_volume_type}"
    volume_size = "${var.ebs_root_volume_size}"
    }
  security_groups = ["${aws_security_group.web_sg.name}"]
  key_name = "${var.my_public_key}"
      tags= {
        Name = "${var.app_name}"
    }
}
# #ボリューム作成
# resource "aws_ebs_volume" "example" {
#   availability_zone = "${var.region}"
#   size              = 1
# }
# #アタッチ
# resource "aws_volume_attachment" "ebs_att" {
#   device_name = "/dev/sdh"
#   volume_id   = "${aws_ebs_volume.example.id}"
#   instance_id = "${aws_instance.ec2.id}"
# }
