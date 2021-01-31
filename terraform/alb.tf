# ALB
resource "aws_lb" "lighthouse-ci-server" {
  name               = "lighthouse-ci-server"
  internal           = false
  load_balancer_type = "application"
  security_groups = [
    aws_security_group.lighthouse-ci-server-alb-sg.id
  ]
  subnets = [
    var.subnet-1a,
    var.subnet-1c,
  ]
}
 
# ALB Target Group
resource "aws_lb_target_group" "lighthouse-ci-server" {
  name                 = "lighthouse-ci-server"
  port                 = "80"
  protocol             = "HTTP"
  target_type          = "ip"
  vpc_id               = var.vpc
  deregistration_delay = "60"
 
  health_check {
    interval            = "10"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = "4"
    healthy_threshold   = "2"
    unhealthy_threshold = "10"
    matcher             = "302"
  }
}
 
# ALB Listener
resource "aws_lb_listener" "lighthouse-ci-server" {
  load_balancer_arn = aws_lb.lighthouse-ci-server.arn
  port              = "80"
  protocol          = "HTTP"
 
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lighthouse-ci-server.arn
  }
}
