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
resource "aws_internet_gateway" "my_igw" {
    vpc_id = aws_vpc.my_vpc.id

    tags = {
        Name = "IGW ${var.tags_name}"
    }
}
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = var.public_route_table_cidr_block
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "Public Route Table ${var.tags_name}"
  }
}
resource "aws_route_table_association" "public_route_table_associations" {
  count = length(aws_subnet.public_subnets[*].id)
  subnet_id = element(aws_subnet.public_subnets[*].id, count.index)
  route_table_id = aws_route_table.public_route_table.id
}

module "security_groups" {
  source = "./security-groups"
  vpc_id = aws_vpc.my_vpc.id
}
