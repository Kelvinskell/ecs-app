# Define policy document
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ecs.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

# Create Role
resource "aws_iam_role" "ecs_execution_role" {
  name               = "ECSAppRole"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json

  inline_policy {
    name = "ecs_execution_policy_for_ecs_app"

    policy = jsonencode(

    )
  }
  tags = {
    Environment = "prod"
  }
}