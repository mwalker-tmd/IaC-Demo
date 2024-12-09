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
