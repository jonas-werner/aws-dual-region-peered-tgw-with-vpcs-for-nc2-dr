# Tokyo route tables and associations
resource "aws_route_table" "JWR_tokyo_public_rt" {
  vpc_id = aws_vpc.JWR_tokyo_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.JWR_tokyo_igw.id
  }
  tags = {
    Name = "${var.project_prefix}_Tokyo_Public_Route_Table"
  }
}

resource "aws_route_table" "JWR_tokyo_private_rt" {
  vpc_id = aws_vpc.JWR_tokyo_vpc.id
  tags = {
    Name = "${var.project_prefix}_Tokyo_Private_Route_Table"
  }
}

resource "aws_route_table_association" "JWR_tokyo_public_rt_assoc" {
  subnet_id      = aws_subnet.JWR_tokyo_public.id
  route_table_id = aws_route_table.JWR_tokyo_public_rt.id
}

resource "aws_route_table_association" "JWR_tokyo_private_a_rt_assoc" {
  subnet_id      = aws_subnet.JWR_tokyo_private_a.id
  route_table_id = aws_route_table.JWR_tokyo_private_rt.id
}

resource "aws_route_table_association" "JWR_tokyo_private_b_rt_assoc" {
  subnet_id      = aws_subnet.JWR_tokyo_private_b.id
  route_table_id = aws_route_table.JWR_tokyo_private_rt.id
}

resource "aws_route_table_association" "JWR_tokyo_private_c_rt_assoc" {
  subnet_id      = aws_subnet.JWR_tokyo_private_c.id
  route_table_id = aws_route_table.JWR_tokyo_private_rt.id
}

resource "aws_route" "JWR_tokyo_private_nat_route" {
  route_table_id         = aws_route_table.JWR_tokyo_private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.JWR_tokyo_nat_gw.id
}

# Osaka route tables and associations
resource "aws_route_table" "JWR_osaka_public_rt" {
  provider = aws.osaka
  vpc_id   = aws_vpc.JWR_osaka_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.JWR_osaka_igw.id
  }
  tags = {
    Name = "${var.project_prefix}_Osaka_Public_Route_Table"
  }
}

resource "aws_route_table" "JWR_osaka_private_rt" {
  provider = aws.osaka
  vpc_id   = aws_vpc.JWR_osaka_vpc.id
  tags = {
    Name = "${var.project_prefix}_Osaka_Private_Route_Table"
  }
}

resource "aws_route_table_association" "JWR_osaka_public_rt_assoc" {
  provider       = aws.osaka
  subnet_id      = aws_subnet.JWR_osaka_public.id
  route_table_id = aws_route_table.JWR_osaka_public_rt.id
}

resource "aws_route_table_association" "JWR_osaka_private_a_rt_assoc" {
  provider       = aws.osaka
  subnet_id      = aws_subnet.JWR_osaka_private_a.id
  route_table_id = aws_route_table.JWR_osaka_private_rt.id
}

resource "aws_route_table_association" "JWR_osaka_private_b_rt_assoc" {
  provider       = aws.osaka
  subnet_id      = aws_subnet.JWR_osaka_private_b.id
  route_table_id = aws_route_table.JWR_osaka_private_rt.id
}

resource "aws_route_table_association" "JWR_osaka_private_c_rt_assoc" {
  provider       = aws.osaka
  subnet_id      = aws_subnet.JWR_osaka_private_c.id
  route_table_id = aws_route_table.JWR_osaka_private_rt.id
}

resource "aws_route" "JWR_osaka_private_nat_route" {
  provider               = aws.osaka
  route_table_id         = aws_route_table.JWR_osaka_private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.JWR_osaka_nat_gw.id
}
