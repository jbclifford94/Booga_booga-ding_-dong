resource "aws_instance" "web1" {
  ami               = "ami-0622eb223ad85775e" # us-east-2
  instance_type     = "t2.micro"
  availability_zone = "us-east-2a"
  key_name          = "wub-aws"
  #  subnet_id       = aws_subnet.web-sub.id
  #  security_groups = [aws_security_group.web-node-sg.id]
  tags = {
    Name = "web1"
  }
}

resource "aws_instance" "web2" {
  ami               = "ami-0622eb223ad85775e" # us-east-2
  instance_type     = "t2.micro"
  availability_zone = "us-east-2c"
  key_name          = "wub-aws"
  #  subnet_id       = aws_subnet.web-sub.id
  #  security_groups = [aws_security_group.web-node-sg.id]
  tags = {
    Name = "web2"
  }
}