data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web1" {
  ami             = data.aws_ami.ubuntu.id # us-east-2
  instance_type   = "t2.micro"
  key_name        = "wub-aws"
  subnet_id       = aws_subnet.subnet_use2a_public.id
  security_groups = [aws_security_group.ssh_anywhere.id]
  tags = {
    Name = "web1"
  }
}

resource "aws_instance" "web2" {
  ami             = data.aws_ami.ubuntu.id # us-east-2
  instance_type   = "t2.micro"
  key_name        = "wub-aws"
  subnet_id       = aws_subnet.subnet_use2c_public.id
  security_groups = [aws_security_group.ssh_anywhere.id]
  tags = {
    Name = "web2"
  }
}
