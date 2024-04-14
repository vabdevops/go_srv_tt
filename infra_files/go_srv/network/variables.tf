variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR value"
  default     = "192.168.0.0/16"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Public Subnet CIDR values"
  default     = ["192.168.1.0/24", "192.168.2.0/24"]
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Private Subnet CIDR values"
  default     = ["192.168.10.0/24", "192.168.20.0/24"]
}

variable "database_subnet_cidrs" {
  type        = list(string)
  description = "Private Subnet CIDR values"
  default     = ["192.168.100.0/24", "192.168.200.0/24"]
}

variable "azs" {
  type        = list(string)
  description = "Availability Zones"
  default     = ["us-east-1a", "us-east-1b"]
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "network-go-srv"
}

variable "tags" {
  description = "Tags for production environment"
  type        = map(string)
  default = {
    appname     = "network-go-srv"
    environment = "test"
    service     = "network"
    region      = "us-east-1"
  }
}

