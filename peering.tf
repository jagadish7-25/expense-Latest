resource "aws_vpc_peering_connection" "peering" {
  count = is_peering_required ? 1 : 0
  peer_vpc_id   = data.aws_vpc.default.id
  vpc_id        = aws_vpc.main.id
  auto_accept = true

  tags = merge(
    var.common_tags,
    var.vpc_peering_tags,
    {
      Name = "${local.resource_name}-vpc-peering"
    }
  )
}
resource "aws_route" "public_peering" {
  count = var.is_peering_required ? 1 : 0
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = data.aws_vpc.default.cidr_block
  vpc_peering_connection_id = data.aws_vpc_peering_connection[count.index].id
}
resource "aws_route" "private_peering" {
  count = var.is_peering_required ? 1 : 0
  route_table_id            = aws_route_table.private.id
  destination_cidr_block    = data.aws_vpc.default.cidr_block
  vpc_peering_connection_id = data.aws_vpc_peering_connection[count.index].id
}
resource "aws_route" "database_peering" {
  count = var.is_peering_required ? 1 : 0
  route_table_id            = aws_route_table.database.id
  destination_cidr_block    = data.aws_vpc.default.cidr_block
  vpc_peering_connection_id = data.aws_vpc_peering_connection[count.index].id
}