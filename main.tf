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

### Networking Resources ###
resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "VPC ${var.tags_name}"
  }
}
resource "aws_subnet" "public_subnets" {
  vpc_id = aws_vpc.my_vpc.id
  count = length(var.public_subnet_cidrs)
  cidr_block = element(var.public_subnet_cidrs, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name = "Public Subnets ${var.tags_name}"
  }
}
resource "aws_subnet" "private_subnets" {
  vpc_id = aws_vpc.my_vpc.id
  count = length(var.private_subnet_cidrs)
  cidr_block = element(var.private_subnet_cidrs, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name = "Private Subnets ${var.tags_name}"
  }
}