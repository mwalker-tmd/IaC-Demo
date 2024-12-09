output "worker_node_security_group_id" {
  value = aws_security_group.worker-nodes-sg.id
  description = "Security Group Identifier"
}
