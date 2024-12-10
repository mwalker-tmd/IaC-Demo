variable "tags_name" {
  type = string
  description = "Tags name for resources"
  default = "ERROR: Security group variable tags_name not defined."
}
variable "private_subnets" {
  type = list(string)
}
variable "worker_node_security_group_id" {
  default = ""
}
