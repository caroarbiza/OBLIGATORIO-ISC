resource "aws_ecs_cluster" "ecs_appweb" {
  name               = "cluster_appweb"
  capacity_providers = ["FARGATE"]

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_task_definition" "service" {
  family = "service"
  container_definitions = jsonencode([
    {
      name      = "first"
      image     = "caroarbiza/ecom:v1"
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 8080
        }
      ]
    },
    {
      name      = "second"
      image     = "caroarbiza/ecom:v1"
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 8081
        }
      ]
    }
  ])

  # volume {
  #   name      = "service-storage"
  #   host_path = "/ecs/service-storage"
  # }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [us-west-1a, us-west-1e]"
  }
}