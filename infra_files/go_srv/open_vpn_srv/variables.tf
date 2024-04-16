variable "network_name" {
  description = "Project name"
  type        = string
  default     = "network-go-srv"
}

variable "instance_type" {
  description = "Instance type"
  type        = string
  default     = "t2.micro"
}

variable "ssh_pub_key" {
  description = "Value of the public key"
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDyBxm4bXdkDAach/qbCNQVZ8k5p6LSmAGWkGqf/T1iHiOhrhSAm0cLQaSbDKJ9wBtlOPhVlFXdEAybf6RTb1qxPesDs1+ybBZaDyJqeK8IudODOGVCx+hPbifhKJ8v5ZRYBWZZlWUC/V764LRjvC22Zur81su24ozQH2oMZpYaokfnqGWYYXSZuc8209XlzWgm7nvJEBbfcpC+LNGL72YFQcF8yF4CyvWcvU8z/7J+1vmdhIj0mfRXSTP13qZtlzt93LT4+3WW0IPRHYYtxHGzIxtPLos6NthBW7Ed3VkGo9QFkGmp4KiMHOU4zjO8HHL+4ZpTN00l+lmG6bCLEbT1Cyhg2ZfT1j5uvfzKq7RBVXP3durbybUyw6SZgfsm2ws/icp8696IwtMxqxeVqDSUOoXiQsdk50m9aSPBN4Nk6BATYzDQrDqqTyYTgW7SRp0rU5sASkyFcF/M6ZqsUvXCWqyqdTQUKGOs/eRyZb7MqS5MfTZbo4eGcrNAsWZqJ5c= vabram_devops@MBP-Volodymyr"
}

variable "tags" {
  description = "Tags for project resources"
  type        = map(string)
  default = {
    appname     = "vpn-srv"
    environment = "test"
    service     = "vpn"
    region      = "us-east-1"
  }
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "vpn-srv"
}