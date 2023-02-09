resource "aws_instance" "web" {
  ami           = data.aws_ami.centos8.id
  instance_type = var.type == "null" ? "t3.micro" : var.type

  tags = {
    Name = "demo"
  }
}

data "aws_ami" "centos8" {
  most_recent = true
  name_regex = "Centos-8-DevOps-Practice"
  owners = ["973714476881"]
}

variable "type" {
  default = "null"
}

# whenever i want to pick   instance_type = "t3.micro"  it depends on condition
# ? - if it is true then use t3.micro
# : - ifnot then var.type (we can provide in commandline)
# IF IT IS == NULL, NO VALUE PASSED, THEN IT IS TRUE AND I USE T3.MICRO
# ELSE IF USER PASSES SOME VALUE THEN I USE IT (IN COMMANDLINE) -var type="t3.large"