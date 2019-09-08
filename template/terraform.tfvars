#App Name
app_name = "mf-ktsdemo"
#Region
region = "ap-northeast-1"
#Segment Settings
root_segment = "172.16.0.0/16"
public_segment1 = "172.16.0.0/24"
public_segment2 = "172.16.1.0/24"
private_segment1 = "172.16.2.0/24"
private_segment2 = "172.16.3.0/24"
#AZ Settings
public_segment1_az = "ap-northeast-1a"
public_segment2_az = "ap-northeast-1c"
private_segment1_az = "ap-northeast-1a"
private_segment2_az = "ap-northeast-1c"
#SG Settings
ssh_allow_ip = "0.0.0.0/0"
#KeyPair Settings
my_public_key = "kts"
#EBS
ebs_root_device_name = "/dev/xvda"      # same value as the default value of the instance
ebs_root_volume_type = "gp2"            # default is magnetic
ebs_root_volume_size = "20"
ebs_root_delete_on_termination = "true"

#ACM証明書
certificate_arn = "arn:aws:acm:ap-northeast-1:265037060275:certificate/caefc126-0d93-4aec-9d0e-ab8d561a7ec5"

#RDS
db_password = "kts_demo"
db_name = "kts_db"
#サブネット名命名規則

#アプリ名-顧客名-用途
