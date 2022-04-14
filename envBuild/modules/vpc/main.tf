provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}


# VPC


resource "aws_vpc" "main" {
  cidr_block = var.cidr
  instance_tenancy = "default"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = "WebApp"
  }
}



# Internet Gateway


resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"
}


# Route Table
resource "aws_route_table" "r" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = var.vpn_ip
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags = {
    Name = "Internet-Facing"
  }
}

# Subnets

#variable "subnet_name" {}
#
#data "aws_subnet" "vpc_subnet" {
#  id = "${var.subnet_name}"
#}

resource "aws_subnet" "subx1" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = var.subx_cidr1
  availability_zone = var.azs[0]
  tags = {
    Name = var.type["subnet1"]
  }
}

resource "aws_subnet" "subx2" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = var.subx_cidr2
  availability_zone = var.azs[1]
  tags = {
    Name = var.type["subnet2"]
  }
}

resource "aws_subnet" "subx3" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = var.subx_cidr3
  availability_zone = var.azs[2]
  tags = {
    Name = var.type["subnet3"]
  }
}

## Route Table Association
#resource "aws_route_table_association" "a" {
#  gateway_id     = "${aws_internet_gateway.gw.id}"
#  route_table_id = aws_route_table.r.id
#}
#
#resource "aws_route_table_association" "b" {
#  subnet_id      = "${aws_subnet.subx1.id}"
# # subnet_id      = aws_subnet.subx.id
#  route_table_id = aws_route_table.r.id
#}
#
#resource "aws_route_table_association" "c" {
#  subnet_id      = "${aws_subnet.subx2.id}"
# # subnet_id      = aws_subnet.subx.id
#  route_table_id = aws_route_table.r.id
#}
#
#resource "aws_route_table_association" "d" {
#  subnet_id      = "${aws_subnet.subx3.id}"
# # subnet_id      = aws_subnet.subx.id
#  route_table_id = aws_route_table.r.id
#}