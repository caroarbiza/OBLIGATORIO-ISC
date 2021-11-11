
module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 3.0"

  identifier = "webappdb"

  engine            = "mysql"
  engine_version    = "5.7"
  instance_class    = "db.t3.micro"
  allocated_storage = 10

  name     = "webappdb"
  username = "obl"y
  password = "obli1234"
  port     = "3306"

  vpc_security_group_ids = [aws_security_group.rdssg.id]

  tags = {
    Name      = "webapp_rds"
    Terraform = "True"
  }

  # DB subnet group
  subnet_ids = [aws_subnet.subnet_internal_one.id, aws_subnet.subnet_internal_two.id]

  # DB parameter group
  family = "mysql5.7"

  # DB option group
  major_engine_version = "5.7"

  # Database Deletion Protection
  deletion_protection = false
}