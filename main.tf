resource "aws_instance" "my_ec2" {
  ami           = "ami-04dd23e62ed049936" //Ubuntu Server 24.04 LTS
  instance_type = "t2.micro"

  tags = {
    Name = "My EC2 Instance"
  }
}