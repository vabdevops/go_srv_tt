variable "network_name" {
  description = "Project name"
  type        = string
  default     = "network-go-srv"
}

variable "instance_type" {
  description = "Instance type"
  type        = string
  default = "t2.micro"
}

variable "spot_price" {
  description = "Spot price for EC2 instances"
  type        = string
  default = "0.03"
}

variable "container_port" {
  description = "Container port"
  type        = number
  default = 8080
}

variable "min_size_asg" {
  description = "Minimum size of ASG"
  type        = number
  default = 2
}

variable "max_size_asg" {
  description = "Maximum size of ASG"
  type        = number
  default = 5
}

variable "tags" {
  description = "Tags for project resources"
  type        = map(string)
  default = {
    appname     = "ecs"
    environment = "test"
    service     = "network"
    region      = "us-east-1"
  }
}

variable "project_name" {
  description = "Project name"
  type        = string
  default = "go-srv"
}


