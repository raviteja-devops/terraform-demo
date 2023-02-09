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
    user = {
      name = "user"
      instance_type = "t3.small"
    }
  }
}

locals {
  instance_type = {for k, v in var.components : k => v.instance_type}
  name = {for k, v in var.components : k => v.name}
}

output "instance_type" {
  value = local.instance_type
}

output "name" {
  value = local.name
}

# local is used to declare local values
# big expressions need to be used in multiple places, locals can help to keep it in one place and
# we refer with another simple variable all the time to make code easy.