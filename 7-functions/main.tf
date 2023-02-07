data "aws_ami" "centos8" {
  most_recent = true
  name_regex = "Centos-8-DevOps-Practice"
  owners = ["973714476881"]
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.centos8.id
  instance_type = "t3.micro"

  tags = {
    Name = "test-centos8"
  }
}

output "instance_profile" {
  value = try(aws_instance.web.*.id[1], "")
}

# id[1] keyword doesn't exist, so it try and if it not exist return a empty value "", instead of error
