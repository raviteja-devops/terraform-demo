resource "aws_instance" "web" {
  count         = 2
  ami           = data.aws_ami.centos8.id
  instance_type = "t3.micro"

  tags = {
    Name = "test-centos8"
  }
}

data "aws_ami" "centos8" {
  most_recent = true
  name_regex = "Centos-8-DevOps-Practice"
  owners = ["973714476881"]
}

output "public_ip" {
  # value = aws_instance.web.public_ip
  # without count

  value = aws_instance.web.*.public_ip
  # with count
}

# '*' means all instances in count, gives public ip of all instances

