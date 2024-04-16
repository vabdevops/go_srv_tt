data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["${var.network_name}-vpc"]
  }
}

data "aws_subnet" "private_subnets_1" {
  filter {
    name   = "tag:Name"
    values = ["${var.network_name}-priv-sub-1"]
  }
}

data "aws_subnet" "private_subnets_2" {
  filter {
    name   = "tag:Name"
    values = ["${var.network_name}-priv-sub-2"]
  }
}

data "aws_subnet" "public_subnets_1" {
  filter {
    name   = "tag:Name"
    values = ["${var.network_name}-pub-sub-1"]
  }
}

data "aws_subnet" "public_subnets_2" {
  filter {
    name   = "tag:Name"
    values = ["${var.network_name}-pub-sub-2"]
  }
}