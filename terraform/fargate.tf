# ECS Cluster
resource "aws_ecs_cluster" "lighthouse-ci-server" {
  name = "lighthouse-ci-server"

  capacity_providers = ["FARGATE_SPOT", "FARGATE"]

  default_capacity_provider_strategy {
    capacity_provider = "FARGATE_SPOT"
  }
 
  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}
 
# ECS Task Definition
resource "aws_ecs_task_definition" "lighthouse-ci-server" {
  family                = "lighthouse-ci-server"
  container_definitions = file("tasks/container_definitions.json")
  cpu                   = "256"
  memory                = "512"
  network_mode          = "awsvpc"
  execution_role_arn    = aws_iam_role.lighthouse-ci-server.arn
 
  volume {
    name = "lighthouse-ci-server"
 
    efs_volume_configuration {
      file_system_id = aws_efs_file_system.lighthouse-ci-server.id
      root_directory = "/"
    }
  }
 
  requires_compatibilities = [
    "FARGATE"
  ]
}
 
# ECS Service
resource "aws_ecs_service" "lighthouse-ci-server" {
  name             = "lighthouse-ci-server"
  cluster          = aws_ecs_cluster.lighthouse-ci-server.arn
  task_definition  = aws_ecs_task_definition.lighthouse-ci-server.arn
  desired_count    = 0
  platform_version = "1.4.0"
 
  load_balancer {
    target_group_arn = aws_lb_target_group.lighthouse-ci-server.arn
    container_name   = "lighthouse-ci-server"
    container_port   = "9001"
  }

  capacity_provider_strategy {
    capacity_provider = "FARGATE_SPOT"
    weight            = 2
  }

  capacity_provider_strategy {
    capacity_provider = "FARGATE"
    weight            = 1
  } 

  network_configuration {
    subnets = [
      var.subnet-1a,
      var.subnet-1c,
    ]
    security_groups = [
      aws_security_group.lighthouse-ci-server-fargate-sg.id
    ]
    assign_public_ip = true
  }
}
