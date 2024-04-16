# Description: This file contains the code to create VPC, Subnets, Route Tables, Internet Gateway, NAT Gateway, Elastic IP, etc.
# Create VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  tags = merge(var.tags, {
    Name = "${var.project_name}-vpc"
  })
}

# Create Internet Gateway for VPC
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = merge(var.tags, {
    Name = "${var.project_name}-igw"
  })
}

# Create Public Subnets
resource "aws_subnet" "public_subnets" {
  count             = length(var.public_subnet_cidrs)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = element(var.public_subnet_cidrs, count.index)
  availability_zone = element(var.azs, count.index)

  tags = merge(var.tags, {
    Name = "${var.project_name}-pub-sub-${count.index + 1}"
  })
}

# Create Private Subnets
resource "aws_subnet" "private_subnets" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = element(var.private_subnet_cidrs, count.index)
  availability_zone = element(var.azs, count.index)

  tags = merge(var.tags, {
    Name = "${var.project_name}-priv-sub-${count.index + 1}"
  })
}

# Create Database Subnets
resource "aws_subnet" "database_subnets" {
  count             = 2
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = element(var.database_subnet_cidrs, count.index)
  availability_zone = element(var.azs, count.index)

  tags = merge(var.tags, {
    Name = "${var.project_name}-dat-sub-${count.index + 1}"
  })
}

# Create Public Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(var.tags, {
    Name = "${var.project_name}-pub-rt"
  })

  lifecycle {
    ignore_changes = all
  }
}

# Create Association for Public Subnets
resource "aws_route_table_association" "public_subnet_asso" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
  route_table_id = aws_route_table.public_rt.id
}

# Create NAT Gateway
resource "aws_nat_gateway" "nat_gateway" {
  count         = length(var.public_subnet_cidrs)
  allocation_id = aws_eip.nat_eip[count.index].id
  subnet_id     = element(aws_subnet.public_subnets[*].id, count.index)
  tags = merge(var.tags, {
    Name = "${var.project_name}-nat-gateway-${count.index + 1}"
  })
}

# Create Elastic IP for NAT Gateway
resource "aws_eip" "nat_eip" {
  count = length(var.public_subnet_cidrs)
  vpc   = true
  tags = merge(var.tags, {
    Name = "${var.project_name}-nat-eip-${count.index + 1}"
  })
}

# Create Private Route Table
resource "aws_route_table" "private_rt" {
  count  = length(var.private_subnet_cidrs)
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway[count.index].id
  }

  tags = merge(var.tags, {
    Name = "${var.project_name}-priv-rt-${count.index + 1}"
  })

  lifecycle {
    ignore_changes = all
  }
}

# Create Association for Private Subnets
resource "aws_route_table_association" "private_subnet_asso" {
  count          = length(var.private_subnet_cidrs)
  subnet_id      = element(aws_subnet.private_subnets[*].id, count.index)
  route_table_id = aws_route_table.private_rt[count.index].id
}

# Create Database Route Table
resource "aws_route_table" "database_rt" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(var.tags, {
    Name = "${var.project_name}-dat-rt"
  })
}

# Create Association for Database Subnets
resource "aws_route_table_association" "database_subnet_asso" {
  count          = length(var.database_subnet_cidrs)
  subnet_id      = element(aws_subnet.database_subnets[*].id, count.index)
  route_table_id = aws_route_table.database_rt.id
}