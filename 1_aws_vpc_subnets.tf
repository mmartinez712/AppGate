resource "aws_vpc" "VPC_AppGate" {
  cidr_block = "10.1.96.0/24"
  enable_dns_hostnames = true
  tags = {
    Name = "VPC_AppGate"
  }
}

resource "aws_subnet" "Public_subnet_1" {
  vpc_id = aws_vpc.VPC_AppGate.id
  cidr_block = "10.1.96.0/27"
  availability_zone = "us-west-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "Public_subnet_1"
  }
}

resource "aws_subnet" "Public_subnet_2" {
  vpc_id = aws_vpc.VPC_AppGate.id
  cidr_block = "10.1.96.32/27"
  availability_zone = "us-west-2b"
  map_public_ip_on_launch = true
  tags = {
    Name = "Public_subnet_2"
  }
}

resource "aws_subnet" "Private_subnet_1" {
  vpc_id = aws_vpc.VPC_AppGate.id
  cidr_block = "10.1.96.64/27"
  availability_zone = "us-west-2a"
  map_public_ip_on_launch = false
  tags = {
    Name = "Private_subnet_1"
  }
}

resource "aws_subnet" "Private_subnet_2" {
  vpc_id = aws_vpc.VPC_AppGate.id
  cidr_block = "10.1.96.96/27"
  availability_zone = "us-west-2b"
  map_public_ip_on_launch = false
  tags = {
    Name = "Private_subnet_2"
  }
}

resource "aws_subnet" "Private_subnet_3" {
  vpc_id = aws_vpc.VPC_AppGate.id
  cidr_block = "10.1.96.128/27"
  availability_zone = "us-west-2c"
  map_public_ip_on_launch = false
  tags = {
    Name = "Private_subnet_3"
  }
}