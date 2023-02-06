data "aws_ami" "example" {
  most_recent = true
  name_regex = "Centos-8-DevOps-Practice"
  owners = ["973714476881"]
}

# most_recent, name_regex, owners -- Arguements
# arguements are the input we provide to data

output "ami" {
  value = data.aws_ami.example
}

# attributes are the information that it is going to fetch by data
# attributes are the output we get from data
# It will fetch data, the data side key-words is called attributes

data "aws_instance" "instance" {
  instance_id = "i-0d1569df18c7d5857"
}

output "instance" {
  value = data.aws_instance.instance.private_ip
}