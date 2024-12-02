# Tokyo VPC and related resources
resource "aws_vpc" "JWR_tokyo_vpc" {
  cidr_block = var.tokyo_vpc_cidr
  tags = {
    Name = "${var.project_prefix}_Tokyo_VPC"
  }
}

resource "aws_subnet" "JWR_tokyo_public" {
  vpc_id                  = aws_vpc.JWR_tokyo_vpc.id
  cidr_block              = "10.101.1.0/24"
  availability_zone       = var.tokyo_az
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project_prefix}_Tokyo_Public_Subnet"
  }
}

resource "aws_subnet" "JWR_tokyo_private_a" {
  vpc_id            = aws_vpc.JWR_tokyo_vpc.id
  cidr_block        = "10.101.2.0/24"
  availability_zone = var.tokyo_az
  tags = {
    Name = "${var.project_prefix}_Tokyo_Private_Subnet_A"
  }
}

resource "aws_subnet" "JWR_tokyo_private_b" {
  vpc_id            = aws_vpc.JWR_tokyo_vpc.id
  cidr_block        = "10.101.3.0/24"
  availability_zone = var.tokyo_az
  tags = {
    Name = "${var.project_prefix}_Tokyo_Private_Subnet_B"
  }
}

resource "aws_subnet" "JWR_tokyo_private_c" {
  vpc_id            = aws_vpc.JWR_tokyo_vpc.id
  cidr_block        = "10.101.4.0/24"
  availability_zone = var.tokyo_az
  tags = {
    Name = "${var.project_prefix}_Tokyo_Private_Subnet_C"
  }
}

resource "aws_internet_gateway" "JWR_tokyo_igw" {
  vpc_id = aws_vpc.JWR_tokyo_vpc.id
  tags = {
    Name = "${var.project_prefix}_Tokyo_Internet_Gateway"
  }
}

resource "aws_eip" "JWR_tokyo_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "JWR_tokyo_nat_gw" {
  allocation_id = aws_eip.JWR_tokyo_eip.id
  subnet_id     = aws_subnet.JWR_tokyo_public.id
  tags = {
    Name = "${var.project_prefix}_Tokyo_NAT_Gateway"
  }
  depends_on = [aws_internet_gateway.JWR_tokyo_igw]
}
