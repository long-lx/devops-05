locals {
  region = "ap-southeast-1"
  name   = "devops-05"
}

variable "ec2_instance_type" {
  description = "Type of Ec2 instance"
  default     = "t2.micro"
}
