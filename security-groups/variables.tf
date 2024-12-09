variable "vpc_id" {
  type = string
  description = "VPC Identifier"
  default = "ERROR: Security group variable vpc_id not defined."
}
variable "trusted_cidr_blocks" {
  type = list(string)
  description = "List of CIDR blocks to allow traffic from"
  default = ["136.36.138.110/32"]
}
variable "tags_name" {
  type = string
  description = "Tags name for resources"
  default = "ERROR: Security group variable tags_name not defined."
}