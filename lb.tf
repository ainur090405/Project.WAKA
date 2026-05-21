resource "aws_lb" "latihan_lb" {
  name               = "latihan-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.latihan-security-group-PKM.id]
  subnets            = [aws_subnet.latihan_subnet_public_pkm.id, aws_subnet.latihan_subnet_public2_pkm.id]
}

resource "aws_lb_target_group" "latihan_tg" {
  name        = "latihan-tg"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = aws_vpc.latihan_vpc_pkm.id
}

resource "aws_lb_target_group_attachment" "latihan-lb-tga1" {
  target_group_arn = aws_lb_target_group.latihan_tg.arn
  target_id        = aws_instance.latihan_ec2PKM.id
  port             = 8080
}

resource "aws_lb_target_group_attachment" "latihan-lb-tga2" {
  target_group_arn = aws_lb_target_group.latihan_tg.arn
  target_id        = aws_instance.latihan-ec2-2-PKM.id
  port             = 8080
}

resource "aws_lb_listener" "latihan_lb_listener" {
  load_balancer_arn = aws_lb.latihan_lb.arn
  port                = "80"
  protocol            = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.latihan_tg.arn
  }
}