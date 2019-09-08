#App Name
variable "app_name" {}
#Region
variable "region" {}
#Segment Settings
variable "root_segment" {}
variable "public_segment1" {}
variable "public_segment2" {}
variable "private_segment1" {}
variable "private_segment2" {}
#AZ Settings
variable "public_segment1_az" {}
variable "public_segment2_az" {}
variable "private_segment1_az" {}
variable "private_segment2_az" {}
#SG Settings
variable "ssh_allow_ip" {}
#KeyPair Settings
variable "my_public_key" {}

#EBS
variable ebs_root_device_name {}      # same value as the default value of the instance
variable ebs_root_volume_type {}            # default is magnetic
variable ebs_root_volume_size {}
variable ebs_root_delete_on_termination {}

#certificate

variable "certificate_arn" {}

variable "db_password" {}

variable "db_name" {}


