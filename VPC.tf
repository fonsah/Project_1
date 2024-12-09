terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  required_version = ">= 1.0.0"
}

resource "aws_vpc" "Nam-vpc" {
  cidr_block = "10.1.0.0/16"
  tags = {
    Name = "Nam-vpc"
  }
}

resource "aws_subnet" "Nam-public-subnet-01" {
  vpc_id                  = aws_vpc.Nam-vpc.id
  cidr_block              = "10.1.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-west-2a"
  tags = {
    Name = "Nam-public-subnet-01"
  }
}

resource "aws_subnet" "Nam-public-subnet-02" {
  vpc_id                  = aws_vpc.Nam-vpc.id
  cidr_block              = "10.1.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-west-2b"
  tags = {
    Name = "Nam-public-subnet-02"
  }
}

resource "aws_security_group" "my_sg" {
  name   = "my_sg"
  vpc_id = aws_vpc.Nam-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
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
    Name = "my_sg"
  }
}

resource "aws_internet_gateway" "Nam-igw" {
  vpc_id = aws_vpc.Nam-vpc.id
  tags = {
    Name = "Nam-igw"
  }
}

resource "aws_route_table" "Nam-public-rt" {
  vpc_id = aws_vpc.Nam-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Nam-igw.id
  }

  tags = {
    Name = "Nam-public-rt"
  }
}

resource "aws_route_table_association" "Nam-rta-public-subnet-01" {
  subnet_id      = aws_subnet.Nam-public-subnet-01.id
  route_table_id = aws_route_table.Nam-public-rt.id
}

resource "aws_route_table_association" "Nam-rta-public-subnet-02" {
  subnet_id      = aws_subnet.Nam-public-subnet-02.id
  route_table_id = aws_route_table.Nam-public-rt.id
}
