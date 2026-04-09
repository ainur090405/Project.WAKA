provider "aws" {
    region = "ap-southeast-2"
}

resource "aws_instance" "Latihan_ec2PKM" {
    ami             = "ami-0ef6d0055be7553ee"
    instance_type   = "t3.micro"
    key_name        = aws_key_pair.latihanKeyPairPKM.key_name
    vpc_security_group_ids = [aws_security_group.latihan-security-group-PKM.id]
    user_data = "${file ("scriptku.sh")}"

    tags = {
        Name = "Latihan-ec2PKM"
    }
}

resource "aws_security_group" "latihan-security-group-PKM" {
    description = "Allow limited inboud external traffic"
    name = "latihan_sg"

    ingress {
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        from_port = 22
        to_port = 22
    }

    ingress {
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        from_port = 8080
        to_port = 8080
    }

    egress {
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
        from_port = 0
        to_port = 0
    }

    tags = {
        Name = "latihan-sg"
    }
}


resource "tls_private_key" "rsa" {
    algorithm = "RSA"
    rsa_bits = 4096
}

resource "local_file" "LatihanPrivateKeyPairPKM" {
    filename = "latihanKeyPairPKM"
    content = tls_private_key.rsa.private_key_pem
}

resource "aws_key_pair" "latihanKeyPairPKM" {
    key_name = "latihanKeyPairPKM"
    public_key = tls_private_key.rsa.public_key_openssh
}