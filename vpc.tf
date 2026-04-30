resource "aws_vpc" "latihan_vpc_pkm" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "latihan-vpc-PKM"
  }
}

resource "aws_internet_gateway" "latihan_igw_pkm" {
  vpc_id = aws_vpc.latihan_vpc_pkm.id

  tags = {
    Name = "latihan-igw-PKM"
  }
}

resource "aws_subnet" "latihan_subnet_public_pkm" {
  vpc_id                  = aws_vpc.latihan_vpc_pkm.id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-southeast-2a"

  tags = {
    Name = "latihan-subnet-public-PKM"
  }
}

resource "aws_subnet" "latihan_subnet_private_pkm" {
  vpc_id                  = aws_vpc.latihan_vpc_pkm.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "ap-southeast-2b"

  tags = {
    Name = "latihan-subnet-private-PKM"
  }
}

resource "aws_route_table" "latihan_rt_public_pkm" {
  vpc_id = aws_vpc.latihan_vpc_pkm.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.latihan_igw_pkm.id
  }

  tags = {
    Name = "latihan-rt-public-PKM"
  }
}

resource "aws_route_table_association" "latihan_rta_public_pkm" {
  subnet_id      = aws_subnet.latihan_subnet_public_pkm.id
  route_table_id = aws_route_table.latihan_rt_public_pkm.id
}

resource "aws_network_acl" "latihan_acl_pkm" {
  vpc_id = aws_vpc.latihan_vpc_pkm.id

  # Inbound: Block ICMP/ping dari semua IP
  ingress {
    protocol   = "icmp"
    rule_no    = 100
    action     = "deny"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
    icmp_type  = -1
    icmp_code  = -1
  }

  # Inbound: Allow SSH (port 22) dari semua IP
  ingress {
    protocol   = "tcp"
    rule_no    = 101
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }

  # Outbound: Allow semua protokol dan semua port
  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "latihan-acl-PKM"
  }
}

resource "aws_network_acl_association" "latihan_acl_assoc_pkm" {
  network_acl_id = aws_network_acl.latihan_acl_pkm.id
  subnet_id      = aws_subnet.latihan_subnet_private_pkm.id
}

