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

### Provider Variables ###
variable "aws_region" {
  default = "us-west-2"
}
variable "aws_profile" {
  default = "mlw-idctr-profile"
}

### Output Variables ###
output "instance_id" {
  value = aws_instance.my_ec2.id
  description = "EC2 Instance Identifier"
}
output "instance_public_ip" {
  value = aws_instance.my_ec2.public_ip
  description = "EC2 Instance Public IP Address"
}
