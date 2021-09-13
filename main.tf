provider "aws" {
  region = var.region
}

###create VPC###
resource "aws_vpc" "module_vpc" {
  cidr_block = var.vpc_cidr_block
  enable_dns_hostnames = true

  tags = {
    Name="Production-VPC"
  }
}

###create public subnets###

resource "aws_subnet" "module_public_subnet_1" {
  cidr_block = var.public_subnet_1_cidr
  vpc_id = aws_vpc.module_vpc.id

  #availability zone a
  availability_zone = "${var.region}a"

  tags = {
    Name="Public-Subnet-1"
  }
}

resource "aws_subnet" "module_public_subnet_2" {
  cidr_block = var.public_subnet_2_cidr
  vpc_id = aws_vpc.module_vpc.id

  #availability zone b
  availability_zone = "${var.region}b"

  tags = {
    Name="Public-Subnet-2"
  }
}

resource "aws_subnet" "module_public_subnet_3" {
  cidr_block = var.public_subnet_3_cidr
  vpc_id = aws_vpc.module_vpc.id

  #availability zone c
  availability_zone = "${var.region}c"

  tags = {
    Name="Public-Subnet-3"
  }
}

###create private subnets###

resource "aws_subnet" "module_private_subnet_1" {
  cidr_block = var.private_subnet_1_cidr
  vpc_id = aws_vpc.module_vpc.id

  #az a
  availability_zone = "${var.region}a"

  tags = {
    Name="Private-Subnet-1"
  }
}

resource "aws_subnet" "module_private_subnet_2" {
  cidr_block = var.private_subnet_2_cidr
  vpc_id = aws_vpc.module_vpc.id

  #az b
  availability_zone = "${var.region}b"

  tags = {
    Name="Private-Subnet-2"
  }
}

resource "aws_subnet" "module_private_subnet_3" {
  cidr_block = var.private_subnet_3_cidr
  vpc_id = aws_vpc.module_vpc.id

  #az c
  availability_zone = "${var.region}"

  tags = {
    Name="Private-Subnet-3"
  }
}

###Route Table for Public Routes###
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.module_vpc.id
  tags = {
    Name="Public-Route-Table"
  }
}

###Route Table for Private Routes###
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.module_vpc.id
  tags = {
    Name="Private-Route-Table"
  }
}

###Associating Route Tables with Subnets###

resource "aws_route_table_association" "public_subnet_1_association" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id = aws_subnet.module_public_subnet_1.id
}

resource "aws_route_table_association" "public_subnet_2_association" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id = aws_subnet.module_public_subnet_2.id
}

resource "aws_route_table_association" "public_subnet_3_association" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id = aws_subnet.module_public_subnet_3.id
}

resource "aws_route_table_association" "private_subnet_1_association" {
  route_table_id = aws_route_table.private_route_table.id
  subnet_id = aws_subnet.module_private_subnet_1.id
}

resource "aws_route_table_association" "private_subnet_2_association" {
  route_table_id = aws_route_table.private_route_table.id
  subnet_id = aws_subnet.module_private_subnet_2.id
}

resource "aws_route_table_association" "private_subnet_3_association" {
  route_table_id = aws_route_table.private_route_table.id
  subnet_id = aws_subnet.module_private_subnet_3.id
}

###Elastic IP for NAT Gateway###
resource "aws_eip" "elastic_ip_for_nat_gw" {
  vpc = True
  associate_with_private_ip = var.eip_association_address

  tags = {
    Name="Production-EIP"
  }
}