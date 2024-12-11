variable "tags_name" {
  type = string
  description = "Tags name for resources"
  default = "ERROR: Variable tags_name not defined."
}
variable "private_subnets" {
  type = list(string)
}
variable "worker_node_security_group_id" {
  type = string
  default = ""
}
variable "vpc_id" {
  type = string
  default = "ERROR: Variable vpc_id not defined."
}
