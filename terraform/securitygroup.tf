# Security Group
resource "aws_security_group" "lighthouse-ci-server-alb-sg" {
  name        = "lighthouse-ci-server-alb-sg"
  description = "lighthouse-ci-server for ALB."
  vpc_id      = var.vpc
}
 
resource "aws_security_group" "lighthouse-ci-server-fargate-sg" {
  name        = "lighthouse-ci-server-fargate-sg"
  description = "lighthouse-ci-server for Fargate."
  vpc_id      = var.vpc
}
 
resource "aws_security_group" "lighthouse-ci-server-efs-sg" {
  name        = "lighthouse-ci-server-efs-sg"
  description = "lighthouse-ci-server for EFS."
  vpc_id      = var.vpc
}
 
# Security Group Rules ingress
resource "aws_security_group_rule" "allow-http-for-alb" {
  security_group_id = aws_security_group.lighthouse-ci-server-alb-sg.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = ["x.x.x.x/32"]
  description       = "lighthouse-ci-server allow http for alb."
}
 
resource "aws_security_group_rule" "from-alb-to-fargate" {
  security_group_id        = aws_security_group.lighthouse-ci-server-fargate-sg.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 9001
  to_port                  = 9001
  source_security_group_id = aws_security_group.lighthouse-ci-server-alb-sg.id
  description              = "lighthouse-ci-server from alb to fargate."
}
 
resource "aws_security_group_rule" "from-fargate-to-efs" {
  security_group_id        = aws_security_group.lighthouse-ci-server-efs-sg.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 2049
  to_port                  = 2049
  source_security_group_id = aws_security_group.lighthouse-ci-server-fargate-sg.id
  description              = "lighthouse-ci-server from fargate to efs."
}
 
# Security Group Rules egress
resource "aws_security_group_rule" "egress-alb" {
  security_group_id = aws_security_group.lighthouse-ci-server-alb-sg.id
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "lighthouse-ci-server Outbound ALL."
}
 
resource "aws_security_group_rule" "egress_fargate" {
  security_group_id = aws_security_group.lighthouse-ci-server-fargate-sg.id
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "lighthouse-ci-server Outbound ALL."
}
 
resource "aws_security_group_rule" "egress_efs" {
  security_group_id = aws_security_group.lighthouse-ci-server-efs-sg.id
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "lighthouse-ci-server Outbound ALL."
}
