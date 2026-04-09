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
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-southeast-2a"

  tags = {
    Name = "latihan-subnet-public-PKM"
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

resource "aws_security_group" "latihan_sg_pkm" {
  name        = "latihan-sg-PKM"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_vpc.latihan_vpc_pkm.id

  ingress {
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
  }

  ingress {
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 8080
    to_port     = 8080
  }

  egress {
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
  }

  tags = {
    Name = "latihan-sg-PKM"
  }
}

resource "local_file" "private_key_pkm" {
  filename = "latihanKeyPairPKM.pem"
  content  = tls_private_key.rsa.private_key_pem
}

resource "aws_key_pair" "latihan_keypair_pkm" {
  key_name   = "latihanKeyPairPKM2"
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "aws_instance" "latihan_ec2_pkm" {
  ami           = "ami-0ef6d0055be7553ee"
  instance_type = "t3.micro"

  subnet_id = aws_subnet.latihan_subnet_public_pkm.id

  key_name = aws_key_pair.latihan_keypair_pkm.key_name

  vpc_security_group_ids = [
    aws_security_group.latihan_sg_pkm.id
  ]

  user_data = file("scriptku.sh")

  tags = {
    Name = "latihan-ec2-PKM"
  }
}