resource "aws_instance" "Instance_AppGate" {
  ami           = "ami-0341aeea105412b57"
  instance_type = "t3.micro"
  associate_public_ip_address = true
  subnet_id = aws_subnet.Public_subnet_1.id
  vpc_security_group_ids = [aws_security_group.security_group_AppGate.id]
  key_name = "key_AppGate"
  user_data = file("apache_docker.sh")
  count = 2
  tags = {
    Name = "Instance_AppGate${count.index}"
  }
}

resource "aws_ebs_volume" "data_test" {
  size = "10"
  availability_zone = "us-west-2a"
  type = "gp2"
  count = 2
  tags = {
    Name = "data_test${count.index}"
  }
}

resource "aws_volume_attachment" "attach" {
  device_name = "/dev/sdh"
  count = 2
  instance_id = element(aws_instance.Instance_AppGate.*.id, count.index)
  volume_id   = element(aws_ebs_volume.data_test.*.id, count.index)
}