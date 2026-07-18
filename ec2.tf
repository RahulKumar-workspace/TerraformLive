# key pair - for login
resource "aws_key_pair" "my_key" {
  key_name = "terra-key-ec2"
  public_key = file(pathexpand("~/.ssh/terra-key-ec2.pub")) # it will read content from this file
}

# VPC & Security Group
resource "aws_default_vpc" "default" {
  
}

resource "aws_security_group" "my_security_group" {
  name = "automate-sg"
  description = "this will add a TF generated Security Group"
  vpc_id = aws_default_vpc.default.id # Interpolation
# Interpolation -> # Interpolation -> It is a way in which you can inherit or extract values form a terraform block.

  tags = {
    Name = "automate-sg"
  }

# Inbound Rules
  ingress {
    from_port = 22 // SSH access
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH Open"
  }

  ingress {
    from_port = 80 // HTTP access
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP Open"
  }

  ingress {
    from_port = 443 // HTTPS access
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTPS Open"
  }

ingress {
  from_port   = 8000
  to_port     = 8000
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  description = "Port 8000 Open"
}

# Outbound Rules
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1" // semantically equivalent to all
    cidr_blocks = ["0.0.0.0/0"]
    description = "All access open outbound"

  }
}

# ec2 instance
resource "aws_instance" "my_instance" {
  key_name = aws_key_pair.my_key.key_name # Interpolation
  security_groups = [aws_security_group.my_security_group.name]
  instance_type = "t2.micro"
  ami = "ami-0b6d9d3d33ba97d99" # Ubuntu

  root_block_device {
    volume_size = 15
    volume_type = "gp3"
  }

  tags = {
    Name = "TWS-Junoon-Automate-July17"
  }
}