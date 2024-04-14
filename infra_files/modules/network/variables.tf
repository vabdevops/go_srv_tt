# VPC Variables >>>

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR value"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Public Subnet CIDR values"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Private Subnet CIDR values"
}

variable "database_subnet_cidrs" {
  type        = list(string)
  description = "Database Subnet CIDR values"
}

variable "azs" {
  type        = list(string)
  description = "Availability Zones"
}

variable "tags" {
  description = "Tags for project resources"
  type        = map(string)
}

variable "project_name" {
  description = "Project name"
  type        = string
}
