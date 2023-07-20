#this file consists of code for instances and sg
provider "aws" {
region = "ap-south-1"
access_key = "AKIARWNLKDGL4PBAFEHI"
secret_key = "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"
}

resource "aws_instance" "one" {
  ami             = "ami-006935d9a6773e4ec"
  instance_type   = "t2.medium"
  key_name        = "terraform"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "ap-south-1"
  user_data       = <<EOF
#!/bin/bash
sudo -i
yum install httpd -y
systemctl start httpd
chkconfig httpd on
echo "hai all this is my app created by terraform infrastructurte by raham sir server-1" > /var/www/html/index.html
EOF
  tags = {
    Name = "web-serverr-1"
  }
}

resource "aws_instance" "two" {
  ami             = "ami-006935d9a6773e4ec"
  instance_type   = "t2.medium"
  key_name        = "terraform"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "ap-south-1"
  user_data       = <<EOF
#!/bin/bash
sudo -i
yum install httpd -y
systemctl start httpd
chkconfig httpd on
echo "hai all this is my website created by terraform infrastructurte by raham sir server-2" > /var/www/html/index.html
EOF
  tags = {
    Name = "web-server-2"
  }
}

resource "aws_instance" "three" {
  ami             = "ami-006935d9a6773e4ec"
  instance_type   = "t2.medium"
  key_name        = "terraform"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "ap-south-1"
  tags = {
    Name = "app-server-1"
  }
}

resource "aws_instance" "four" {
  ami             = "ami-006935d9a6773e4ec"
  instance_type   = "t2.medium"
  key_name        = "terraform"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "ap-south-1"
  tags = {
    Name = "app-server-2"
  }
}

resource "aws_security_group" "five" {
  name = "elb-sg"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
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
}

resource "aws_s3_bucket" "six" {
  bucket = "hemanth123"
}

resource "aws_iam_user" "seven" {
for_each = var.user_names
name = each.value
}

variable "user_names" {
description = "*"
type = set(string)
default = ["user1", "user2", "user3", "user4"]
}

resource "aws_ebs_volume" "eight" {
 availability_zone = "ap-south-1"
  size = 40
  tags = {
    Name = "ebs-001"
  }
}
