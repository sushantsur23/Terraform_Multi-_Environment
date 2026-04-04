# EC2 instance

# Create key pair
resource "aws_key_pair" "deployer" {
  key_name   = "terra-key-pair"
  public_key = file("D:/Documents/BLog/Terraform_Multi-_Environment/terra-key.pub")
  
  }

#Using Default VPC

resource "aws_default_vpc" "name" {
  tags = {
    Name = "Default VPC"
  }
}

#Creating security group to ssh to the intance with a port 22
resource "aws_security_group" "twssecurity" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_default_vpc.name.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    description  = "this is outgoing traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_instance" "my-instance" {
  count = var.instance_count
  ami = var.ami_id
  instance_type = var.instance_type

  security_groups = [aws_security_group.twssecurity.name]
  tags = {
    Name = "${var.my_env}-terra-automate"
  }
}