resource "aws_ecr_repository" "todo_api" {

  name = "wiz-todo-api"

  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Project     = "wiz-tech-exercise"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}