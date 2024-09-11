terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "ec2-iac-pub-aula2" {
  ami           = "ami-0e86e20dae9224db8"
  instance_type = "t2.micro"

  tags = {
    Name = "ec2-iac-aula2-pub"
  }

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_type = "gp3"
    volume_size = 30
  }

  vpc_security_group_ids = [aws_security_group.sg_aula_iac_tarefa.id]

  key_name = "aula-iac"

  subnet_id = aws_subnet.sub_pub_sptech.id
}

resource "aws_instance" "ec2-iac-pri-aula2" {
  ami           = "ami-0e86e20dae9224db8"
  instance_type = "t2.micro"

  tags = {
    Name = "ec2-iac-aula2_pri"
  }

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_type = "gp3"
    volume_size = 30
  }

  key_name = "aula-iac"

  subnet_id = aws_subnet.sub_pri_sptech.id
}

variable "porta_http" {
  description = "porta http"
  default = 80
  type = number
}

variable "porta_https" {
  description = "porta https"
  default = 443
  type = number
}

resource "aws_security_group" "sg_aula_iac_tarefa" {
  name = "sg_aula_iac_tarefa"
  vpc_id = aws_vpc.vpc_sptech.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_vpc" "vpc_sptech" {
  tags = {
    Name = "vpc_sptech"
  }
  cidr_block = "10.0.0.0/24"
}

resource "aws_subnet" "sub_pri_sptech" {
  tags = {
    Name = "sub_pri_sptech"
  }
  vpc_id = aws_vpc.vpc_sptech.id
  cidr_block = "10.0.0.0/25"
}

resource "aws_subnet" "sub_pub_sptech" {
  tags = {
    Name = "sub_pub_sptech"
  }
  vpc_id = aws_vpc.vpc_sptech.id
  cidr_block = "10.0.0.128/25"
}
