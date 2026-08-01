terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

# Get latest Amazon Linux 2023 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

# Create EC2
resource "aws_instance" "my_ec2" {

  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"

  tags = {
    Name        = "Terraform-EC2"
    Environment = "Dev"
    ManagedBy   = "Terraform"
  }
}

output "instance_id" {
  value = aws_instance.my_ec2.id
}

output "private_ip" {
  value = aws_instance.my_ec2.private_ip
}

output "public_ip" {
  value = aws_instance.my_ec2.public_ip
}