data "aws_ami" "ami" {
  most_recent = true
  name_regex = "Centos-8-DevOps-Practice"
  owners = ["973714476881"]
}

# most_recent, name_regex, owners -- Arguements

output "ami" {
  value = "data.aws_ami.ami"
}