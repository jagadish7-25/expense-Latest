output "vpc_id" {
    value = aws_vpc.main.id
  
}
output "vpc_default" {
    value = data.aws_vpc.default
  
}
output "main_route_table_info" {
 value = data.aws_route_table.main
 }