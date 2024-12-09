### Output Variables ###
output "instance_id" {
  value = aws_instance.my_ec2.id
  description = "EC2 Instance Identifier"
}
output "instance_public_ip" {
  value = aws_instance.my_ec2.public_ip
  description = "EC2 Instance Public IP Address"
}
output "vpc_id" {
  value = aws_vpc.my_vpc.id
  description = "VPC Identifier"
}
output "worker_node_security_group" {
  value = module.security_groups.worker_node_security_group_id
  description = "Worker Nodes Security Group Identifier"
}