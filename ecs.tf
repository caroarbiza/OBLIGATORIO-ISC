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
      name      = "appweb"
      image     = "caroarbiza/ecom:v5"
      essential = true
      command   = ["./script.sh"]
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]

    }

  ])
  depends_on = [module.db]


}


resource "aws_ecs_service" "ecs_task1" {
  name            = "ecs_task1"
  task_definition = aws_ecs_task_definition.task1.arn
  cluster         = aws_ecs_cluster.cluster_appweb.id
  launch_type     = "FARGATE"
  desired_count   = 2
  network_configuration {
    subnets          = [aws_subnet.subnet_public_one.id, aws_subnet.subnet_public_two.id]
    security_groups  = [aws_security_group.allow_ssh_http.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.appwbeb_tg.arn
    container_name   = "appweb"
    container_port   = 80
  }

}








