variable "az" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1e"]
}

variable "vpc.id" {
  type    = string
  default = aws_vpc.vpc_webapp.id
}

variable "db.name" {
  type    = string
  default = "idukan"
}

variable "db.user" {
  type    = string
  default = "obl"
}

variable "db.pass" {
  type    = string
  default = "obli1234"
}

variable "db.port" {
  type    = number
  default = 3306
}