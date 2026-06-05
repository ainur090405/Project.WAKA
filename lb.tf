resource "aws_lb" "latihan_lb" {
  name               = "latihan-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.latihan-security-group-PKM.id]
  subnets            = [aws_subnet.latihan_subnet_public_pkm.id, aws_subnet.latihan_subnet_public2_pkm.id]
}

resource "aws_lb_target_group" "latihan_tg" {
  name        = "latihan-tg3"
  port        = 3000
  protocol    = "HTTP"
  vpc_id      = aws_vpc.latihan_vpc_pkm.id

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_listener" "latihan_lb_listener" {
  load_balancer_arn = aws_lb.latihan_lb.arn
  port                = "3000"
  protocol            = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.latihan_tg.arn
  }
}