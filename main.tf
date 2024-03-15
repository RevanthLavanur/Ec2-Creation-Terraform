resource "aws_security_group" "webSg" {
  name   = "web"
  # vpc_id = aws_vpc.myvpc.id

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Web-sg"
  }
}
resource "aws_instance" "webserver1" {
  ami           = "ami-013168dc3850ef002"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.webSg.id]
  # subnet_id = aws_subnet.sub1.id
  # user_data = base64encode(file("userdata.sh"))
  user_data = file("userdata.sh")
}

