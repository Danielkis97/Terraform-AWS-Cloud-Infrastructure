
resource "aws_lb_target_group" "web_target_group" {
  name     = "web-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 2
    timeout             = 15
    interval            = 30
    matcher             = "200"
  }

  tags = {
    Name = "web-target-group"
  }
}

resource "aws_lb" "mein_lb" {
  name               = "WebshopLB-${terraform.workspace}-${random_string.suffix.id}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.default_sg]
  subnets            = aws_subnet.main_subnet[*].id
  enable_deletion_protection      = false
  enable_cross_zone_load_balancing = true
  idle_timeout                    = 60

  tags = {
    Name = "WebshopLB-${terraform.workspace}-${random_string.suffix.id}"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.mein_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_target_group.arn
  }
}
