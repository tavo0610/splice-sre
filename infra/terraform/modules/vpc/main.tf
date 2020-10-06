locals {
  public_subnets  = zipmap(var.public_azs, var.public_cidr_blocks)
  private_subnets = zipmap(var.private_azs, var.private_cidr_blocks)
}

resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block_vpc
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    "Name"      = "${var.project}"
    Environment = var.environment_tag
  }
}

resource "aws_subnet" "public" {
  for_each          = local.public_subnets
  vpc_id            = aws_vpc.main.id
  availability_zone = each.key
  cidr_block        = each.value

  tags = {
    Name        = "Public Subnet AZ-${each.key}"
    Environment = var.environment_tag
  }
}

resource "aws_subnet" "private" {
  for_each          = local.private_subnets
  vpc_id            = aws_vpc.main.id
  availability_zone = each.key
  cidr_block        = each.value

  tags = {
    Name        = "Private Subnet AZ-${each.key}"
    Environment = var.environment_tag
  }
}

resource "aws_eip" "nat_gw_elastic_ip" {
  vpc = true

  tags = {
    Name        = "${var.project}-nat-eip"
    Environment = var.environment_tag
  }
}


resource "aws_nat_gateway" "gw" {
  for_each          = local.private_subnets
  allocation_id = aws_eip.nat_gw_elastic_ip.id
  subnet_id     = aws_subnet.private[each.key].id

  tags = {
    Name = "Nat GW"
    Environment = var.environment_tag
  }
}