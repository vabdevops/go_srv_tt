data "aws_ami" "latest_ubuntu_image" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-*-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["${var.network_name}-vpc"]
  }
}

data "aws_subnet" "public_subnets" {
  filter {
    name   = "tag:Name"
    values = ["${var.network_name}-pub-sub-1"]
  }
}