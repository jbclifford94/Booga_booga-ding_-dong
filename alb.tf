resource "aws_lb" "web-alb" {
  name               = "web-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["sg-47e16833"]
  subnets            = ["subnet-229f2249", "subnet-bae0b3f6"]


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
  vpc_id      = "vpc-9eed78f5"
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
