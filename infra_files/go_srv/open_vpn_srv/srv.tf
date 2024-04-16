resource "aws_security_group" "open_vpn_sg" {
  name_prefix = "${var.project_name}-open-vpn-sg"
  vpc_id      = data.aws_vpc.vpc.id

  dynamic "ingress" {
    for_each = [1194, 943, 22, 80, 443]
    content {
      protocol    = "tcp"
      from_port   = ingress.value
      to_port     = ingress.value
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "${var.project_name} Open VPN Security Group"
  })
}

resource "aws_key_pair" "open_vpn_key_pair" {
  key_name   = "${var.project_name}-open-vpn-key"
  public_key = var.ssh_pub_key
}

resource "aws_instance" "open_vpn_server" {
  ami             = data.aws_ami.latest_ubuntu_image.id
  instance_type   = var.instance_type
  subnet_id       = data.aws_subnet.public_subnets.id
  key_name        = aws_key_pair.open_vpn_key_pair.key_name
  security_groups = [aws_security_group.open_vpn_sg.id]
  tags = merge(var.tags, {
    Name = "${var.project_name}"
  })
}

resource "aws_eip" "open_vpn" {
  instance = aws_instance.open_vpn_server.id
  vpc      = true
}

output "open_vpn_public_ip" {
  value = aws_eip.open_vpn.public_ip

}