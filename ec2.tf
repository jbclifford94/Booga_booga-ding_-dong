resource "aws_ami" "web1" {
  name = "JCEAWeb1"

  ebs_block_device {
    device_name = "/dev/sdh"
    snapshot_id = "snap-050ca58b45223c217"
  }
}  

resource "aws_ami" "web2" {
  name = "JCEAWeb2"

  ebs_block_device {
    device_name = "/dev/sdh"
    snapshot_id = "snap-01c879bc06f286b19"
  }
}  

resource "aws_instance" "web1" {
  ami               = "web1"
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
  ami               = "web2"
  instance_type     = "t2.micro"
  availability_zone = "us-east-2c"
  key_name          = "wub-aws"
  #  subnet_id       = aws_subnet.web-sub.id
  #  security_groups = [aws_security_group.web-node-sg.id]
  tags = {
    Name = "web2"
  }
}
