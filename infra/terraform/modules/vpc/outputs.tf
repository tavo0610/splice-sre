output "subnet_private_ids" {
  value = { for k, subnet_id in aws_subnet.private : k => subnet_id.id }
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "security_group_ids" {
  value = aws_security_group.eks.id
}
