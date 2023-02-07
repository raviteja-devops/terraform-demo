resource "aws_instance" "web" {
  ami           = data.aws_ami.centos8.id
  instance_type = "t3.micro"
  vpc_security_group_ids = [var.security_group_id]

  tags = {
    Name = "test-centos8"
  }
}

# vpc_security_group_ids = [var.security_group_id] is because we decalred variable