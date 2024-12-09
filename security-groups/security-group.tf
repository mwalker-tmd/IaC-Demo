
resource "aws_security_group" "worker-nodes-sg" {
  vpc_id = var.vpc_id
  description = "Security Group for Worker Nodes"
  name = "Worker Nodes Sec Group ${var.tags_name}"

  tags = {
    Name = "Worker Nodes Security Group"
  }

  ingress {
    description = "Allow SSH traffic from trusted CIDR blocks"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.trusted_cidr_blocks
  }
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}