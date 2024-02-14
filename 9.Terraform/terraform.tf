# vpc setup

resource "aws_vpc" "lms_vpc" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = "true"
  tags = {
    Name = "lms-vpc"
  }
}

resource "aws_subnet" "lms_public_subnet" {
  vpc_id                  = aws_vpc.lms_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.lms_vpc.id
}

resource "aws_route_table" "lms_public_route_table" {
  vpc_id = aws_vpc.lms_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
}

resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.lms_public_subnet.id
  route_table_id = aws_route_table.lms_public_route_table.id
}

# Security Group
resource "aws_security_group" "lms-sg" {
  name        = "allow-lms-sg"
  description = "Allow SSH - HTTP inbound traffic"
  vpc_id      = aws_vpc.lms_vpc.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "lms-sg"
  }
}

# server
resource "aws_instance" "ec2-server" {
  ami           = "ami-06478978e5e72679a"  # Replace with your desired AMI ID
  instance_type = "t2.medium"
  key_name      = "linuxkey"  # Replace with your key pair name

  vpc_security_group_ids = [aws_security_group.lms-sg.id]
  subnet_id             = aws_subnet.lms_public_subnet.id             # Replace with your subnet ID, you will get while creating the Subnet using Terraform

  tags = {
    Name = "ec2-tf-server"
  }
}

# output
# this file is used to print vpc-id and subnet-id,public-ip we will use them in firewall and server file

output "vpc_id" {
  value = aws_vpc.lms_vpc.id
}

output "subnet_id" {
  value = aws_subnet.lms_public_subnet.id
}
output "server_public_ip" {
  value = aws_instance.ec2-server.public_ip
}
