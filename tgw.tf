# Transit Gateways
resource "aws_ec2_transit_gateway" "JWR_tokyo_tgw" {
  description                     = "${var.project_prefix} Tokyo Transit Gateway"
  default_route_table_association = "enable"
  default_route_table_propagation = "enable"
  tags = {
    Name = "${var.project_prefix}_Tokyo_TGW"
  }
}

resource "aws_ec2_transit_gateway" "JWR_osaka_tgw" {
  provider                        = aws.osaka
  description                     = "${var.project_prefix} Osaka Transit Gateway"
  default_route_table_association = "enable"
  default_route_table_propagation = "enable"
  tags = {
    Name = "${var.project_prefix}_Osaka_TGW"
  }
}

# TGW VPC Attachments
resource "aws_ec2_transit_gateway_vpc_attachment" "JWR_tokyo_attachment" {
  subnet_ids         = [aws_subnet.JWR_tokyo_private_a.id]
  transit_gateway_id = aws_ec2_transit_gateway.JWR_tokyo_tgw.id
  vpc_id             = aws_vpc.JWR_tokyo_vpc.id
  
  tags = {
    Name = "${var.project_prefix}_Tokyo_VPC_TGW_Attachment"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "JWR_osaka_attachment" {
  provider           = aws.osaka
  subnet_ids         = [aws_subnet.JWR_osaka_private_a.id]
  transit_gateway_id = aws_ec2_transit_gateway.JWR_osaka_tgw.id
  vpc_id             = aws_vpc.JWR_osaka_vpc.id
  
  tags = {
    Name = "${var.project_prefix}_Osaka_VPC_TGW_Attachment"
  }
}

# TGW Peering
resource "aws_ec2_transit_gateway_peering_attachment" "JWR_tgw_peering" {
  peer_region             = var.osaka_region
  peer_transit_gateway_id = aws_ec2_transit_gateway.JWR_osaka_tgw.id
  transit_gateway_id      = aws_ec2_transit_gateway.JWR_tokyo_tgw.id
  
  tags = {
    Name = "${var.project_prefix}_Tokyo-Osaka_TGW_Peering"
  }
}

resource "aws_ec2_transit_gateway_peering_attachment_accepter" "JWR_osaka_accepter" {
  provider                      = aws.osaka
  transit_gateway_attachment_id = aws_ec2_transit_gateway_peering_attachment.JWR_tgw_peering.id
  
  tags = {
    Name = "${var.project_prefix}_Osaka_TGW_Peering_Accepter"
  }
}

# TGW Routes
resource "aws_ec2_transit_gateway_route" "JWR_tokyo_to_osaka" {
  destination_cidr_block         = var.osaka_vpc_cidr
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.JWR_tgw_peering.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway.JWR_tokyo_tgw.association_default_route_table_id
  depends_on = [
    aws_ec2_transit_gateway_peering_attachment_accepter.JWR_osaka_accepter
  ]
}

resource "aws_ec2_transit_gateway_route" "JWR_osaka_to_tokyo" {
  provider                       = aws.osaka
  destination_cidr_block         = var.tokyo_vpc_cidr
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.JWR_tgw_peering.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway.JWR_osaka_tgw.association_default_route_table_id
  depends_on = [
    aws_ec2_transit_gateway_peering_attachment_accepter.JWR_osaka_accepter
  ]
}

# VPC Routes to TGW
resource "aws_route" "JWR_tokyo_private_to_tgw" {
  route_table_id         = aws_route_table.JWR_tokyo_private_rt.id
  destination_cidr_block = var.osaka_vpc_cidr
  transit_gateway_id     = aws_ec2_transit_gateway.JWR_tokyo_tgw.id
  depends_on = [
    aws_ec2_transit_gateway_vpc_attachment.JWR_tokyo_attachment
  ]
}

resource "aws_route" "JWR_osaka_private_to_tgw" {
  provider               = aws.osaka
  route_table_id         = aws_route_table.JWR_osaka_private_rt.id
  destination_cidr_block = var.tokyo_vpc_cidr
  transit_gateway_id     = aws_ec2_transit_gateway.JWR_osaka_tgw.id
  depends_on = [
    aws_ec2_transit_gateway_vpc_attachment.JWR_osaka_attachment
  ]
}
