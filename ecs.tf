resource "aws_ecs_cluster" "cluster_appweb" {
  name               = "cluster_appweb"
  capacity_providers = ["FARGATE"]

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_service" "ecs_appweb" {
  name            = "ecs_appweb"
  task_definition = aws_ecs_task_definition.service.arn
  cluster         = aws_ecs_cluster.cluster_appweb.id

  load_balancer {
    target_group_arn = aws_lb_target_group.appwbeb_tg.arn
    container_name   = "first"
    container_port   = 80
  }

}

resource "aws_ecs_task_definition" "service" {
  family = "service"
  container_definitions = jsonencode([
    {
      name      = "first"
      image     = "caroarbiza/ecom:v1"
      cpu       = 1
      memory    = 512
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
      cpu       = 1
      memory    = 512
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