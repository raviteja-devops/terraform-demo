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

module "ec2" {
  source = "./module"

  for_each = var.components
  instance_type = each.value.instance_type
  name = each.value.name
}

# THIS IS THE BEST CODE, IF WE NEED TO ADD ANOTHER INSTANCE THEN WE ONLY NEED TO CHANGE IN "VARIABLE COMPONENTS" SIDE
# WE ARE NOT TOUCHING MODULE

# ALWAYS ITERATE MODULES, NOT RESOURCES
# ALWAYS MAP THE DATA AND USE FOR-EACH LOOP
