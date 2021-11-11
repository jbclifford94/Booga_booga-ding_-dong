resource "aws_lb" "web-alb" {
  name               = "web-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ssh_anywhere.id]
  subnets            = [aws_subnet.subnet_use2a_public.id, aws_subnet.subnet_use2c_public.id]


  enable_deletion_protection = false


  tags = {
    Environment = "production"
  }
}

resource "aws_lb_target_group" "web-tg" {
  name        = "web-lb-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.good_vpc.id
}

resource "aws_alb_listener" "web-alb-listener" {
  load_balancer_arn = aws_lb.web-alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.web-tg.id
    type             = "forward"
  }
}

resource "aws_lb_target_group_attachment" "web1-tga" {
  target_group_arn = aws_lb_target_group.web-tg.arn
  target_id        = aws_instance.web1.id
  port             = 80
}
resource "aws_lb_target_group_attachment" "web2-tga" {
  target_group_arn = aws_lb_target_group.web-tg.arn
  target_id        = aws_instance.web2.id
  port             = 80
}
