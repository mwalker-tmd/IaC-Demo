### Resource Variable Values ###
ami = "ami-04dd23e62ed049936" # Ubuntu 20.04 LTS
instance_type = "t2.micro"
tags_name = "IaC Demo - v0.4.0"
metadata_options-http_tokens = "required"
monitoring = true
ebs_optimized = true
root_block_device-encrypted = true

### Networking Variable Values ###
vpc_cidr_block = "10.0.0.0/16"
public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
private_subnet_cidrs = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
public_route_table_cidr_block = "0.0.0.0/0"
availability_zones = ["us-west-2a", "us-west-2b", "us-west-2c"]

### Provider Variable Values ###
aws_region  = "us-west-2"
aws_profile = "mlw-idctr-profile"
