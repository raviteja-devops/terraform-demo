# when we have multiple resources and we want to loop it, COUNT comes into picture

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
  # '*' comes in place when we have resource in a loop

  # value = aws_instance.web.*.public_ip[0]
  # we are accessing the list by its index, here we get public_ip of 1st instance, if [1] - 2nd instance etc.
}

# '*' means all instances in count, gives public ip of all instances in count
# In earlier terraform version, when we change from normal resource to list of resources (count), it destroy old resource and create new resource
# Now wheather its a maturity on terraform side or amazon plugin side, it is detecting the normal resouce and converting it into list resources



# Count maybe necessarly need not come in resources, it can be come in multiple ways.

resource "aws_instance" "web" {
  count         = length(var.components)
  ami           = data.aws_ami.centos8.id
  instance_type = "t3.micro"

  tags = {
    Name = var.components[count.index]
  }
}
# tags provide appropriate names by using count.index based on variables components

data "aws_ami" "centos8" {
  most_recent = true
  name_regex = "Centos-8-DevOps-Practice"
  owners = ["973714476881"]
}

variable "components" {
  default = ["cart", "catalogue"]
}

# here we are using FUNCTION length, it calculates how many number of values are there in list
# we can control it from variable

# THE INPUT IS NOT GOING TO BE SAME ALL THE TIME IN TERRAFORM, EACH INSTANCE REQUIRES SAPERATE CONFIGURATION
# FOR-EACH FULLFILLS THAT REQUIREMENT