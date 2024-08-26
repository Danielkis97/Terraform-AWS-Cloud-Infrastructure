variable "aws_access_key" {
  description = "Your AWS Access Key"
  type        = string
  sensitive   = true
}

variable "aws_secret_key" {
  description = "Your AWS Secret Key"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "eu-north-1"
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
  default     = "vpc-0daa63c1609c48921"
}

variable "ami" {
  description = "The ID of the Amazon Machine Image (AMI)"
  type        = string
  default     = "ami-079c4d86630be4b6a"
}

variable "instance_type" {
  description = "The instance type to use"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "The key name for SSH access"
  type        = string
  default     = "key"
}

variable "subnet_cidrs" {
  description = "List of Subnet CIDRs"
  type        = list(string)
  default     = ["172.31.1.0/24", "172.31.2.0/24", "172.31.3.0/24"]
}

variable "default_sg" {
  description = "The ID of the default Security Group"
  type        = string
  default     = "sg-09e26a866d300c34f"
}
