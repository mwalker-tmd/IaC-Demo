resource "aws_instance" "my_ec2" {
  ami           = var.ami
  instance_type = var.instance_type
  monitoring = var.monitoring

  tags = {
    Name = var.tags_name
  }

  metadata_options {
    http_tokens = var.metadata_options-http_tokens
  }
}
