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

module "ec2" {
  source = "./module"

  for_each = var.components
  instance_type = each.value.instance_type
  name = each.value.name
}

output "public_ip" {
  value = {
    for k, v in module.ec2 : k => v["ec2"].public_ip
  }
}
# v is coming with ec2, v is component and it is coming with ec2 because we declared in module output, then public_ip

# THIS IS THE BEST CODE, IF WE NEED TO ADD ANOTHER INSTANCE THEN WE ONLY NEED TO CHANGE IN "VARIABLE COMPONENTS" SIDE
# WE ARE NOT TOUCHING MODULE

# ALWAYS ITERATE MODULES, NOT RESOURCES
# ALWAYS MAP THE DATA AND USE FOR-EACH LOOP
