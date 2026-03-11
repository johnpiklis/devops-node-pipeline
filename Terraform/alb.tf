resource "aws_lb" "app_lb" {
  name               = "devops-lb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.public_subnet.id]
  security_groups    = [aws_security_group.app_sg.id]
}

resource "aws_lb_target_group" "app_tg" {
  name     = "devops-target-group"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = aws_vpc.devops_vpc.id
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}