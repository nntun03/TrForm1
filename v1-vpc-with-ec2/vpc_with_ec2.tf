provider "aws" {
  region = var.region
}

resource "aws_instance" "demo-server" {
  ami = var.os-name
  instance_type =  var.instance-type
  key_name = var.key-name
  availability_zone = var.subnet-az
  subnet_id = aws_subnet.demo-subnet.id
  vpc_security_group_ids = [  aws_security_group.demo-vpc-aws_sg.id]
  tags = {
    Name = "demo-server-1"
  }
  

}
resource "aws_vpc" "demo-vpc" {
  cidr_block = var.vpc-cidr
  tags = {
    Name = "demo-vpc-under-tags"
  }
}

resource "aws_subnet" "demo-subnet" {
  vpc_id     = aws_vpc.demo-vpc.id
  cidr_block = var.subnet1-cidr
  availability_zone = var.subnet-az
  map_public_ip_on_launch = true

  tags = {
    Name = "demo_subnet"
  }
}

resource "aws_internet_gateway" "demo-igw" {
  vpc_id = aws_vpc.demo-vpc.id

  tags = {
    Name = "demo-igw"
  }
}

resource "aws_route_table" "demo-rt" {
  vpc_id = aws_vpc.demo-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo-igw.id
  }

  tags = {
    Name = "demo-rt"
  }
}

resource "aws_route_table_association" "demo-rta" {
  subnet_id      = aws_subnet.demo-subnet.id
  route_table_id = aws_route_table.demo-rt.id
}

resource "aws_security_group" "demo-vpc-aws_sg" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.demo-vpc.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}
