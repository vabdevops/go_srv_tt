data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name"
    values = ["amazon/al2023-ami-2023.*.x86_64-gp2"]
  }
}