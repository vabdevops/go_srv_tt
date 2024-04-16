resource "aws_security_group" "http" {
  name_prefix = "${var.project_name}-http"
  description = "Allow all HTTP traffic from public"
  vpc_id      = var.vpc_id
  dynamic "ingress" {
    for_each = [80]
    content {
      protocol    = "tcp"
      from_port   = ingress.value
      to_port     = ingress.value
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(var.tags, {
    Name = "${var.project_name}-http"
  })
}

resource "aws_lb" "main" {
  name               = "${var.project_name}-alb"
  load_balancer_type = "application"
  subnets            = var.public_subnet_ids
  security_groups    = [aws_security_group.http.id]

  tags = merge(var.tags, {
    Name = "${var.project_name}-alb"
  })
}

resource "aws_lb_target_group" "app" {
  name_prefix = "srv-"
  vpc_id      = var.vpc_id
  protocol    = "HTTP"
  port        = var.container_port
  target_type = "ip"

  health_check {
    enabled             = true
    path                = "/ping"
    port                = var.container_port
    matcher             = 200
    interval            = 10
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 3
  }
  tags = merge(var.tags, {
    Name = "${var.project_name}-tg"
  })
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.id
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.id
  }
  tags = merge(var.tags, {
    Name = "${var.project_name}-http"
  })
}

output "alb_dns_name" {
  value = aws_lb.main.dns_name
}
