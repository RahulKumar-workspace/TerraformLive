# key pair - for login
resource aws_key_pair my_key {
  key_name = "terra-key-ec2"
  public_key = file("terra-key-ec2.pub") # it will read content from this file
}

# VPC & Security Group
resource aws_default_vpc default {
  
}

resource aws_security_group my_security_group {
  name = "automate-sg"
  description = "this will add a TF generated Security Group"
  vpc_id = aws_default_vpc.default # InterPolation
# Interpolation -> It is a way in which you can inherit or extract the values form a terraform block.

  tags = {
    Name = "automate-sg"
  }

# Inbund Rules
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

# Outbound Rules
  egress = {

  }
}


# ec2 instance

