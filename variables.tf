### EC2 Instance Variables ###
variable "ami" {
  default = "ERROR: Variable ami not defined."
}
variable "instance_type" {
  default = "ERROR: Variable instance_type not defined."
}
variable "tags_name" {
  default = "ERROR: Variable tags_name not defined."
}

### Provider Variables ###
variable "aws_region" {
  default = "us-west-2"
}
variable "aws_profile" {
  default = "mlw-idctr-profile"
}
