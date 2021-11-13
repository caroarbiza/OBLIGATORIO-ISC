resource "aws_lb" "appweb_lb" {
  name               = "appweb-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_ssh_http.id]
  subnets            = [aws_subnet.subnet_public_one.id, aws_subnet.subnet_public_two.id]
}

resource "aws_lb_target_group" "appwbeb_tg" {
  name        = "appweb-tg"
  port        = 80
  protocol    = "HTTP"
#  target_type = "ip"
  vpc_id      = aws_vpc.vpc_webapp.id
  tags = {
    Name      = "Appweb_lb"
    Terraform = "True"
  }
  depends_on = [aws_lb.appweb_lb]
}

resource "aws_lb_listener" "appweb_http" {
  load_balancer_arn = aws_lb.appweb_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.appwbeb_tg.arn
  }

}