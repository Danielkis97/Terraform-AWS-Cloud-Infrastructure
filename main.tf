terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}


provider "aws" {
  region     = var.region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

data "aws_availability_zones" "available" {}

resource "aws_subnet" "main_subnet" {
  count                   = 3
  vpc_id                  = var.vpc_id  # Refer to the specified VPC ID
  cidr_block              = element(var.subnet_cidrs, count.index)
  availability_zone       = element(data.aws_availability_zones.available.names, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "main-subnet-${count.index + 1}"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = var.vpc_id  # Refer to the specified VPC ID

  tags = {
    Name = "main-internetgateway"
  }
}

resource "aws_route_table" "main" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "main-route-table"
  }
}

resource "aws_route_table_association" "main" {
  count          = 3
  subnet_id      = aws_subnet.main_subnet[count.index].id
  route_table_id = aws_route_table.main.id
}

resource "aws_security_group" "web_sg" {
  vpc_id = var.vpc_id

  name = "web-sg-${terraform.workspace}-${random_string.suffix.id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

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

  tags = {
    Name = "web-sg-${terraform.workspace}-${random_string.suffix.id}"
  }
}
