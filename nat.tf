resource "aws_eip" "latihan_elastic_ip_pkm" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.latihan_igw_pkm]

  tags = {
    Name = "NAT Gateway EIP"
  }
}

resource "aws_nat_gateway" "latihan_nat_gateway_pkm" {
  allocation_id = aws_eip.latihan_elastic_ip_pkm.id
  subnet_id     = aws_subnet.latihan_subnet_public_pkm.id

  tags = {
    Name = "latihan-nat-gateway-PKM"
  }
}

resource "aws_route_table" "latihan_rt_private_pkm" {
  vpc_id = aws_vpc.latihan_vpc_pkm.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.latihan_nat_gateway_pkm.id
  }

  tags = {
    Name = "latihan-rt-private-PKM"
  }
}

resource "aws_route_table_association" "latihan_rta_private_pkm" {
  subnet_id      = aws_subnet.latihan_subnet_private_pkm.id
  route_table_id = aws_route_table.latihan_rt_private_pkm.id
}
