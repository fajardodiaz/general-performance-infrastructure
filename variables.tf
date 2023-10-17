variable "master_instance_type" {
  type    = string
  default = "c5.xlarge"
}

variable "slave_instance_type" {
  type    = string
  default = "c5.2xlarge"
}

variable "master_instance_count" {
  type = number
}

variable "slave_instance_count" {
  type = number
}

variable "ami" {
  type        = string
  description = "AMI for instance OS"
}

variable "availability_zone" {
  type        = string
  description = "Availability zone for instance"
}

variable "key_name" {
  type        = string
  description = "SSH Key"
}

variable "volume_size" {
  type        = string
  description = "Volume size for ebs"
}

variable "volume_type" {
  type        = string
  description = "Volume type for ebs"
}

variable "environment" {
  type        = string
  description = "Environment"
}