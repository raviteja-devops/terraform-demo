# for-each loop deals with map

resource "aws_instance" "web" {
  for_each = var.components
  ami           = data.aws_ami.centos8.id
  instance_type = each.value["instance_type"]

  tags = {
    Name = each.value["name"]
  }
}

data "aws_ami" "centos8" {
  most_recent = true
  name_regex = "Centos-8-DevOps-Practice"
  owners = ["973714476881"]
}

variable "components" {
  default = {
    cart = {
      name = "cart"
      instance_type = "t3.small"
    }
    catalogue = {
      name = "catalogue"
      instance_type = "t3.micro"
    }
  }
}

output "public_ip" {
  value = {
    for k, v in aws_instance.web : k => v.public_ip
  }
}
# k is key (cart, catalogue) and v is value (all the configuration of components)
# k => v.id  ,  key = value.public_ip

# complexity never arises with COUNT, it only deals with basic things
# complex requirements require FOR-EACH

# IF WE WANT TO WRITE THIS SAME IN BEST APPROACH IS BY USING MODULES