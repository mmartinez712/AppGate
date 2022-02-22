resource "aws_internet_gateway" "internet_gateway_AppGate" {
  vpc_id = aws_vpc.VPC_AppGate.id
  tags =  {
    Name = "internet_gateway_AppGate"
  }
}

resource "aws_route_table" "route_table_AppGate" {
  vpc_id = aws_vpc.VPC_AppGate.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway_AppGate.id
  }
  tags =  {
    Name = "route_table_AppGate"
  }
}

resource "aws_route_table_association" "route_table_association_AppGate" {
  subnet_id = aws_subnet.Public_subnet_1.id
  route_table_id = aws_route_table.route_table_AppGate.id
}

resource "aws_security_group" "security_group_AppGate" {
name = "security_group_AppGate"
vpc_id = aws_vpc.VPC_AppGate.id
description = "security_group_AppGate"

ingress  {
from_port = 22
to_port = 22
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}

ingress  {
from_port = 80
to_port = 80
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}

ingress  {
from_port = 443
to_port = 443
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}

egress  {
from_port = 0
to_port = 0
cidr_blocks = [ "0.0.0.0/0" ]
protocol = "-1"
}
tags =  {
Name = ""
}
}

