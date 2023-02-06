variable "sample" {
  default = 10
}

output "variable" {
  value = var.sample
}


# default variable type
variable "Default" {
  default = "Hello"
}

output "variable1" {
  value = var.Default
}


# list variable
# index 0,1,2....
variable "List" {
  default = [
    100,
    "abc",
    true
  ]
}

output "variable2" {
  value = var.List[2]
}


#map variables
variable "Map" {
  default = {
    number = 100
    string = "abc"
    boolean = true
  }
}

output "variable3" {
  value = var.Map["string"]
}


# variables from .tfvars
variable "demo1" {}

output "variable4" {
  value = var.demo1
}