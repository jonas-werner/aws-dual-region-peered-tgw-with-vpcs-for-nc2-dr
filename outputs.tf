output "tokyo_vpc_id" {
  description = "ID of the Tokyo VPC"
  value       = aws_vpc.JWR_tokyo_vpc.id
}

output "osaka_vpc_id" {
  description = "ID of the Osaka VPC"
  value       = aws_vpc.JWR_osaka_vpc.id
}

output "tokyo_tgw_id" {
  description = "ID of the Tokyo Transit Gateway"
  value       = aws_ec2_transit_gateway.JWR_tokyo_tgw.id
}

output "osaka_tgw_id" {
  description = "ID of the Osaka Transit Gateway"
  value       = aws_ec2_transit_gateway.JWR_osaka_tgw.id
}

output "tgw_peering_id" {
  description = "ID of the Transit Gateway Peering Connection"
  value       = aws_ec2_transit_gateway_peering_attachment.JWR_tgw_peering.id
}
