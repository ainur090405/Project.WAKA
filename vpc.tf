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

