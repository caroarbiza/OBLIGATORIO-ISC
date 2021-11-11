resource "aws_ecs_cluster" "ecs_appweb" {
  name               = "cluster_appweb"
  capacity_providers = ["FARGATE"]

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}