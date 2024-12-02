resource "aws_instance" "my_ec2" {
  ami           = var.ami
  instance_type = var.instance_type
  monitoring = var.monitoring
  ebs_optimized = var.ebs_optimized

  tags = {
    Name = "EC2 ${var.tags_name}"
  }

  metadata_options {
    http_tokens = var.metadata_options-http_tokens
  }

  root_block_device {
    encrypted = var.root_block_device-encrypted
  }
}

resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "VPC ${var.tags_name}"
  }
}
