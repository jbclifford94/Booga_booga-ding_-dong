resource "aws_vpc" "good_vpc" {
  cidr_block           = "10.1.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "good_vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.good_vpc.id
}

resource "aws_subnet" "subnet_use2a_public" {
  vpc_id                  = aws_vpc.good_vpc.id
  cidr_block              = "10.1.0.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-2a"
}

resource "aws_subnet" "subnet_use2c_public" {
  vpc_id                  = aws_vpc.good_vpc.id
  cidr_block              = "10.1.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-2c"
}

resource "aws_route_table" "rtb_public" {
  vpc_id = aws_vpc.good_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "rta_subnet_public" {
  subnet_id      = aws_subnet.subnet_use2a_public.id
  route_table_id = aws_route_table.rtb_public.id
}
resource "aws_eip" "good_IP" {
  vpc = true
}

resource "aws_nat_gateway" "nat_GW" {
  allocation_id = aws_eip.good_IP.id
  subnet_id     = aws_subnet.subnet_use2a_public.id
}
resource "aws_security_group" "ssh_anywhere" {
  vpc_id = aws_vpc.good_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    // This means, all ip address are allowed to ssh ! 
    // Do not do it in the production. 
    // Put your office or home address in it!
    cidr_blocks = ["0.0.0.0/0"]
  }
  //If you do not add this rule, you can not reach the NGIX  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "ssh_anywhere"
  }
}
