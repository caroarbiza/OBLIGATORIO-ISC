module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 6.0"

  name = "appweb-alb"

  load_balancer_type = "application"

  vpc_id          = aws_vpc.vpc_webapp.id
  subnets         = [aws_subnet.subnet_public_one.id, aws_subnet.subnet_public_two.id]
  security_groups = [aws_security_group.allow_ssh_http.id]

  target_groups = [
    {
      name_prefix      = "def"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
      targets = [
        {
          target_id = aws_instance.Instancia1.id
          port      = 80
        },
        {
          target_id = aws_instance.Instancia2.id
          port      = 80
        }

      ]
    }
  ]


  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]

  tags = {
    Name      = "Appweb_alb"
    Terraform = "True"
  }
}