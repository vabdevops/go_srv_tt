resource "aws_ecr_repository" "promova_stage_docker_images" {
  name = var.registry_name
}

resource "aws_ecr_lifecycle_policy" "retain_images" {
  repository = aws_ecr_repository.promova_stage_docker_images.name

  policy = <<EOF
{
  "rules": [
    {
      "rulePriority": 1,
      "description": "Retain the last 3 images",
      "selection": {
        "tagStatus": "any",
        "countType": "imageCountMoreThan",
        "countNumber": 3
      },
      "action": {
        "type": "expire"
      }
    }
  ]
}
EOF
}