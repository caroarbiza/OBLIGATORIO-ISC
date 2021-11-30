
module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 3.0"

  identifier = "webappdb"

  engine            = "mysql"
  engine_version    = "5.7"
  instance_class    = "db.t3.micro"
  allocated_storage = 10

  name     = "idukan"
  username = "obl"
  password = "obli1234"
  port     = "3306"

  vpc_security_group_ids = [aws_security_group.rdssg.id]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  tags = {
    Name      = "webappdb"
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

  #  publicly_accessible = true
}