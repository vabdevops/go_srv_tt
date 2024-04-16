variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "instance_type" {
  description = "Instance type"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs"
  type        = list(string)
}

variable "public_subnet_ids" {
  description = "Public subnet IDs"
  type        = list(string)
}

variable "spot_price" {
  description = "Spot price for EC2 instances"
  type        = string
}

variable "container_port" {
  description = "Container port"
  type        = number
}

variable "min_size_asg" {
  description = "Minimum size of ASG"
  type        = number
}

variable "max_size_asg" {
  description = "Maximum size of ASG"
  type        = number
}

variable "desired_capacity" {
  description = "Desired capacity of ASG"
  type        = number
}

variable "tags" {
  description = "Tags for project resources"
  type        = map(string)
}

variable "project_name" {
  description = "Project name"
  type        = string
}


