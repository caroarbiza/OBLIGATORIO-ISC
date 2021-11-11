resource "aws_instance" "Instancia1" {
  ami                    = "ami-06e2b3882a1e987b7"
  instance_type          = "t2.micro"
  key_name               = "Lab"
  vpc_security_group_ids = [aws_security_group.allow_ssh_http.id]
  subnet_id              = aws_subnet.subnet_internal_one.id
  tags = {
    Name      = "appweb-host01"
    terraform = "True"

  }

}

resource "aws_instance" "Instancia2" {
  ami                    = "ami-06e2b3882a1e987b7"
  instance_type          = "t2.micro"
  key_name               = "Lab"
  vpc_security_group_ids = [aws_security_group.allow_ssh_http.id]
  subnet_id              = aws_subnet.subnet_internal_two.id
  tags = {
    Name      = "appweb-host02"
    terraform = "True"

  }

}