module "ecs_cluster" {
  source        = "../../modules/ecs_cluster"
  vpc_id        = data.aws_vpc.vpc.id
  instance_type = var.instance_type
  spot_price = var.spot_price
  container_port = var.container_port
  min_size_asg = var.min_size_asg
  max_size_asg = var.max_size_asg

  private_subnet_ids = [
    data.aws_subnet.private_subnets_1.id,
    data.aws_subnet.private_subnets_2.id
  ]
  public_subnet_ids = [
    data.aws_subnet.public_subnets_1.id,
    data.aws_subnet.public_subnets_2.id
  ]

  project_name = var.project_name
  tags = var.tags
}

output "alb_dns_name" {
  value = module.ecs_cluster.alb_dns_name
}