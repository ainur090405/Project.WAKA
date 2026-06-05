resource "aws_security_group" "latihan-security-group-PKM" {
  description = "Allow limited inbound external traffic"
  vpc_id      = aws_vpc.latihan_vpc_pkm.id
  name        = "latihan_sg"

  ingress {
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
  }

  ingress {
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 3000
    to_port     = 3000
  }

  ingress {
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    to_port     = 80
  }

  ingress {
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 3306
    to_port     = 3306
  }

  ingress {
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = -1
    to_port     = -1
  }

  egress {
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
  }

  tags = {
    Name = "latihan-sg"
  }
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "LatihanPrivateKeyPairPKM" {
  filename = "latihanKeyPairPKM"
  content  = tls_private_key.rsa.private_key_pem
}

resource "aws_key_pair" "latihanKeyPairPKM" {
  key_name   = "latihanKeyPairPKM"
  public_key = tls_private_key.rsa.public_key_openssh
}

data "template_file" "user_data_pkm" {
  template = "${file("scriptku.sh")}"
  vars = {
    rds_address  = "${aws_db_instance.latihan_db_rds_pkm.address}"
    rds_username = "${aws_db_instance.latihan_db_rds_pkm.username}"
    rds_password = "${aws_db_instance.latihan_db_rds_pkm.password}"
    rds_db_name  = "${aws_db_instance.latihan_db_rds_pkm.db_name}"
  }
}

locals {
  loc_ami = "ami-0ef6d0055be7553ee"
  loc_instance = "t3.micro"
}