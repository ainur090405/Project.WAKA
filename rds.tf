resource "aws_db_subnet_group" "latihan_subnet_db_pkm" {
  name       = "latihan_subnet_db_pkm"
  subnet_ids = [
    aws_subnet.latihan_subnet_private_pkm.id,
    aws_subnet.latihan_subnet_private2_pkm.id
  ]

  tags = {
    Name = "latihan_subnet_db_pkm"
  }
}

resource "aws_security_group" "latihan-rds-sg-pkm" {
  name   = "latihan_rds_sg_pkm"
  vpc_id = aws_vpc.latihan_vpc_pkm.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "latihan_rds_sg_pkm"
  }
}

resource "aws_db_instance" "latihan_db_rds_pkm" {
  identifier             = "latihan-db-rds-pkm"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  engine                 = "mariadb"
  engine_version         = "10.6.19"
  username               = "latihan"
  password               = 12345678
  db_name                = "my_project"
  db_subnet_group_name   = aws_db_subnet_group.latihan_subnet_db_pkm.name
  vpc_security_group_ids = [aws_security_group.latihan-rds-sg-pkm.id]
  publicly_accessible    = false
  skip_final_snapshot    = true
  multi_az               = true
}