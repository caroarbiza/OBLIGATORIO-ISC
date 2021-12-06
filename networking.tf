resource "aws_vpc" "vpc_webapp" {
  cidr_block           = "172.16.0.0/16"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name        = "vpc_webapp"
    Terraform   = "True"
    Description = "VPC for the web application"
  }
}

resource "aws_subnet" "subnet_public_one" {
  vpc_id                  = aws_vpc.vpc_webapp.id
  cidr_block              = "172.16.1.0/24"
  availability_zone       = var.az[0]
  map_public_ip_on_launch = "true"
  tags = {
    Name        = "subnet-public"
    Terraform   = "True"
    Description = "Subnet for the alb"
  }
}
resource "aws_subnet" "subnet_public_two" {
  vpc_id                  = aws_vpc.vpc_webapp.id
  cidr_block              = "172.16.2.0/24"
  availability_zone       = var.az[1]
  map_public_ip_on_launch = "true"
  tags = {
    Name        = "subnet-public-two"
    Terraform   = "True"
    Description = "Subnet for the alb"
  }
}

resource "aws_subnet" "subnet_internal_one" {
  vpc_id                  = aws_vpc.vpc_webapp.id
  cidr_block              = "172.16.3.0/24"
  availability_zone       = var.az[0]
  map_public_ip_on_launch = "true"
  tags = {
    Name        = "subnet-internal"
    Terraform   = "True"
    Description = "Subnet for the instance1"
  }
}

resource "aws_subnet" "subnet_internal_two" {
  vpc_id                  = aws_vpc.vpc_webapp.id
  cidr_block              = "172.16.4.0/24"
  availability_zone       = var.az[1]
  map_public_ip_on_launch = "true"
  tags = {
    Name        = "subnet-internal-two"
    Terraform   = "True"
    Description = "Subnet for the instance2"
  }
}

resource "aws_internet_gateway" "gateway_obl" {
  vpc_id = aws_vpc.vpc_webapp.id
  tags = {
    Name        = "webapp-gateway"
    Terraform   = "True"
    Description = "Gateway for the web application"
  }
}

resource "aws_default_route_table" "defaultroutetable_obl" {
  default_route_table_id = aws_vpc.vpc_webapp.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway_obl.id
  }
  tags = {
    Name        = "rt-obl"
    Terraform   = "True"
    Description = "Route Table for the obl"
  }
} 