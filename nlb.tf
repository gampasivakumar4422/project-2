resource "aws_lb" "network" {
  name               = "network-lb"
  internal           = false
  load_balancer_type = "network"
  security_groups    = ["sg-0bc5cd5487adfa7bd"]
  subnets            = ["subnet-0160fa13810235c75", "subnet-018df9c7bf0674480"]
  tags = {
    Name = "network-lb"
  }
}

resource "aws_lb_target_group" "network" {
  name     = "network-tg"
  port     = 8080
  protocol = "TCP"
  vpc_id   = "vpc-0e7311da59b90d0f8"
  health_check {
    path                = "/Siva"
    interval            = 10
    timeout             = 10
    healthy_threshold   = 2
    unhealthy_threshold = 5
    matcher             = "200-399"
  }
  tags = {    
    Name = "network-tg"
  }
}

resource "aws_lb_listener" "network" {
  load_balancer_arn = aws_lb.network.arn
  port              = 80
  protocol          = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.network.arn
  }
}

resource "aws_lb_target_group_attachment" "web" {
  target_group_arn = aws_lb_target_group.network.arn
  target_id        = aws_instance.web.id
  port             = 8080
}
resource "aws_lb_target_group_attachment" "webserver" {
  target_group_arn = aws_lb_target_group.network.arn
  target_id        = aws_instance.webserver.id
  port             = 8080
}