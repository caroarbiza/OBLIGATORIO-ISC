resource "aws_ecs_cluster" "cluster_appweb" {
  name               = "cluster_appweb"
  capacity_providers = ["FARGATE"]

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_task_definition" "task1" {
  family                   = "task1"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  container_definitions = jsonencode([
    {
      name  = "first"
      image = "caroarbiza/ecom:v1"


      essential = true

      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }

  ])
}

resource "aws_ecs_task_definition" "task2" {
  family                   = "task2"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  container_definitions = jsonencode([
    {
      name = "second"


      image     = "caroarbiza/ecom:v1"
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }


      ]
    }
  ])


  # volume {
  #   name      = "service-storage"
  #   host_path = "/ecs/service-storage"
  # }
}


resource "aws_ecs_service" "ecs_task1" {
  name            = "ecs_task1"
  task_definition = aws_ecs_task_definition.task1.arn
  cluster         = aws_ecs_cluster.cluster_appweb.id
  launch_type     = "FARGATE"
  network_configuration {
    subnets = [aws_subnet.subnet_public_one.id, aws_subnet.subnet_public_two.id]
    security_groups = [aws_security_group.allow_ssh_http.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.appwbeb_tg.arn
    container_name   = "first"
    container_port   = 80
  }

}

resource "aws_ecs_service" "ecs_task2" {
  name            = "ecs_task2"
  task_definition = aws_ecs_task_definition.task2.arn
  cluster         = aws_ecs_cluster.cluster_appweb.id
  launch_type     = "FARGATE"
  network_configuration {
    subnets = [aws_subnet.subnet_public_one.id, aws_subnet.subnet_public_two.id]
    security_groups = [aws_security_group.allow_ssh_http.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.appwbeb_tg.arn
    container_name   = "second"
    container_port   = 80
  }

}






