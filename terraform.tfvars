#App Name
app_name = "sample"
#Region
region = "ap-northeast-1"
#Segment Settings
root_segment = "10.10.0.0/16"
public_segment1 = "10.10.10.0/24"
public_segment2 = "10.10.11.0/24"
private_segment1 = "10.10.200.0/24"
private_segment2 = "10.10.201.0/24"
#AZ Settings
public_segment1_az = "ap-northeast-1a"
public_segment2_az = "ap-northeast-1c"
private_segment1_az = "ap-northeast-1a"
private_segment2_az = "ap-northeast-1c"
#SG Settings
ssh_allow_ip = "[[ 0.0.0.0/0 ]]"
#KeyPair Settings
my_public_key = "libvc"
#EBS
ebs_root_device_name = "/dev/xvda"      # same value as the default value of the instance
ebs_root_volume_type = "magnetic"            # default is magnetic
ebs_root_volume_size = "20"
ebs_root_delete_on_termination = "true"
#サブネット名命名規則
#アプリ名-顧客名-用途
