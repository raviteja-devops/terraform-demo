module "sg" {
  source = "./sg"
}

module "ec2" {
  source = "./ec2"
  security_group_id = module.sg.security_group_id
}
# security_group_id output of sg is going as input to ec2

terraform {
  backend "s3" {
    bucket = "terraform-b70"
    key    = "6-modules/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}

# The Security Group information created in one module, we need to send that information to another module(ec2)
# In terraform this is main challange, This cannot overcome
# we need to send information of one module to another module by using output block
# output in sub-modules acts as data transmission
# output in root module is used to print information

