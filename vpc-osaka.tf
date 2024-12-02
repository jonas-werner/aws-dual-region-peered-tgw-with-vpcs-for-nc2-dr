# Osaka VPC and related resources
resource "aws_vpc" "JWR_osaka_vpc" {
  provider   = aws.osaka
  cidr_block = var.osaka_vpc_cidr
  tags = {
    Name = "${var.project_prefix}_Osaka_VPC"
  }
}

resource "aws_subnet" "JWR_osaka_public" {
  provider               = aws.osaka
  vpc_id                 = aws_vpc.JWR_osaka_vpc.id
  cidr_block             = "10.102.1.0/24"
  availability_zone      = var.osaka_az
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project_prefix}_Osaka_Public_Subnet"
  }
}

resource "aws_subnet" "JWR_osaka_private_a" {
  provider          = aws.osaka
  vpc_id            = aws_vpc.JWR_osaka_vpc.id
  cidr_block        = "10.102.2.0/24"
  availability_zone = var.osaka_az
  tags = {
    Name = "${var.project_prefix}_Osaka_Private_Subnet_A"
  }
}

resource "aws_subnet" "JWR_osaka_private_b" {
  provider          = aws.osaka
  vpc_id            = aws_vpc.JWR_osaka_vpc.id
  cidr_block        = "10.102.3.0/24"
  availability_zone = var.osaka_az
  tags = {
    Name = "${var.project_prefix}_Osaka_Private_Subnet_B"
  }
}

resource "aws_subnet" "JWR_osaka_private_c" {
  provider          = aws.osaka
  vpc_id            = aws_vpc.JWR_osaka_vpc.id
  cidr_block        = "10.102.4.0/24"
  availability_zone = var.osaka_az
  tags = {
    Name = "${var.project_prefix}_Osaka_Private_Subnet_C"
  }
}

resource "aws_internet_gateway" "JWR_osaka_igw" {
  provider = aws.osaka
  vpc_id   = aws_vpc.JWR_osaka_vpc.id
  tags = {
    Name = "${var.project_prefix}_Osaka_Internet_Gateway"
  }
}

resource "aws_eip" "JWR_osaka_eip" {
  provider = aws.osaka
  domain   = "vpc"
}

resource "aws_nat_gateway" "JWR_osaka_nat_gw" {
  provider      = aws.osaka
  allocation_id = aws_eip.JWR_osaka_eip.id
  subnet_id     = aws_subnet.JWR_osaka_public.id
  tags = {
    Name = "${var.project_prefix}_Osaka_NAT_Gateway"
  }
  depends_on = [aws_internet_gateway.JWR_osaka_igw]
}
