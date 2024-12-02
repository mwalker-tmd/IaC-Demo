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

### Provider Variable Values ###
aws_region  = "us-west-2"
aws_profile = "mlw-idctr-profile"
