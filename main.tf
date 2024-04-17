terraform {
  required_version = "~>1.8.0"

  backend "s3" {
    bucket  = "generalinfrastructure"
    key     = "infra/copaloyal/terraform.state"
    region  = "us-east-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.0"
    }
  }
}

provider "aws" {
  region  = "us-east-2"
}

# AWS Security Group
resource "aws_security_group" "sg_instances_performance" {
  name = "Allow ssh from my ip"

  ingress {
    description = "All connections from my Computer"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["190.141.89.0/24"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# AWS Elastic IP
resource "aws_eip_association" "eip_association" {
  instance_id   = aws_instance.master_instance.id
  allocation_id = "eipalloc-09439b0f7fea89f4c"
  depends_on    = [aws_instance.master_instance]
}


# AWS Instances
resource "aws_instance" "master_instance" {
  instance_type               = var.master_instance_type
  ami                         = var.ami
  associate_public_ip_address = true
  availability_zone           = var.availability_zone
  ebs_block_device {
    delete_on_termination = true
    device_name           = "/dev/sda1"
    volume_size           = var.volume_size
    volume_type           = var.volume_type
  }
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.sg_instances_performance.id]

  tags = {
    Name        = "Master Instance - ${var.environment}"
    Environment = var.environment
  }
}

resource "aws_instance" "slave_instance" {
  instance_type               = var.slave_instance_type
  ami                         = var.ami
  associate_public_ip_address = true
  availability_zone           = var.availability_zone
  ebs_block_device {
    delete_on_termination = true
    device_name           = "/dev/sda1"
    volume_size           = var.volume_size
    volume_type           = var.volume_type
  }

  key_name = var.key_name
  vpc_security_group_ids = [ aws_security_group.allow_master_instance.id ]
  count = var.slave_instance_count

  tags = {
    Name        = "Slave Instance - ${count.index + 1}"
    Environment = var.environment
  }
}

resource "aws_security_group" "allow_master_instance" {
  name        = "allow_master_instance"

  ingress {
    description = "Master Instance"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["${aws_instance.master_instance.public_ip}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Master Instance permissions"
  }

  depends_on = [ aws_instance.master_instance ]
}
