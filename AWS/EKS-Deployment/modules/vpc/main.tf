resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = merge({ Name = "${var.tags["Environment"]}-vpc" }, var.tags)
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this.id
  tags = merge({ Name = "${var.tags["Environment"]}-igw" }, var.tags)
}

resource "aws_subnet" "public" {
  count = length(var.azs)
  vpc_id = aws_vpc.this.id
  cidr_block = var.public_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]
  map_public_ip_on_launch = true
  tags = merge({ Name = "public-${count.index}" }, var.tags)
}

resource "aws_subnet" "private" {
  count = length(var.azs)
  vpc_id = aws_vpc.this.id
  cidr_block = var.private_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]
  tags = merge({ Name = "private-${count.index}" }, var.tags)
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  tags = merge({ Name = "public-rt" }, var.tags)
}

resource "aws_route_table_association" "public_assoc" {
  count = length(aws_subnet.public)
  subnet_id = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# NAT Gateway for private subnets (one NAT per AZ)
resource "aws_eip" "nat" {
  count = length(var.azs)
  vpc = true
}

resource "aws_nat_gateway" "natgw" {
  count = length(var.azs)
  allocation_id = aws_eip.nat[count.index].id
  subnet_id = aws_subnet.public[count.index].id
  tags = merge({ Name = "nat-${count.index}" }, var.tags)
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id
  tags = merge({ Name = "private-rt" }, var.tags)
}

resource "aws_route" "private_default" {
  count = length(aws_subnet.private)
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.natgw[count.index].id
}

resource "aws_route_table_association" "private_assoc" {
  count = length(aws_subnet.private)
  subnet_id = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

resource "aws_security_group" "default" {
  name        = "${var.tags["Environment"]}-sg"
  description = "Default security group for the VPC"
  vpc_id      = aws_vpc.this.id
  tags = merge({ Name = "${var.tags["Environment"]}-sg" }, var.tags)
}

output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnets" {
  value = aws_subnet.public[*].id
}

output "private_subnets" {
  value = aws_subnet.private[*].id
}

output "default_security_group_id" {
  value = aws_security_group.default.id
}

