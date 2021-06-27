resource "aws_vpc" "vpc" {
  cidr_block           = "10.1.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_subnet" "subnet_public" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.1.0.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-2a"
}

resource "aws_route_table" "rtb_public" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "rta_subnet_public" {
  subnet_id      = aws_subnet.subnet_public.id
  route_table_id = aws_route_table.rtb_public.id
}

resource "aws_security_group" "sg_22" {
  name   = "sg_22"
  vpc_id = aws_vpc.vpc.id
  ingress {
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
}

resource "aws_key_pair" "ec2key" {
  key_name   = "publicKey"
  public_key = "/home/wub/projects/github/AWS_WebLB/terraform.tfvars"
}

resource "aws_instance" "testInstance" {
  ami                    = "ami-0622eb223ad85775e"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.subnet_public.id
  vpc_security_group_ids = ["${aws_security_group.sg_22.id}"]
  key_name               = aws_key_pair.ec2key.key_name
}