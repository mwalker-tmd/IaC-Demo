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
variable "metadata_options-http_tokens" {
    default = "ERROR: Variable metadata_options-http_tokens not defined."
}
variable "monitoring" {
  default = "ERROR: Variable monitoring not defined."
}
variable "ebs_optimized" {
  default = "ERROR: Variable ebs_optimized not defined."
}
variable "root_block_device-encrypted" {
  default = "ERROR: Variable root_block_device-encrypted not defined."
}

### Networking Variables ###
variable "vpc_cidr_block" {
  default = "ERROR: Variable vpc_cidr_block not defined."
}
variable "public_subnet_cidrs" {
  type = list(string)
  default = []
}
variable "private_subnet_cidrs" {
  type = list(string)
  default = []
}
variable "availability_zones" {
    type = list(string)
    default = []
}
variable "public_route_table_cidr_block" {
    default = "ERROR: Variable public_route_table_cidr_block not defined."
}

### Provider Variables ###
variable "aws_region" {
  default = "us-west-2"
}
variable "aws_profile" {
  default = "mlw-idctr-profile"
}
