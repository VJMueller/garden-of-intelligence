data "github_repository" "this" {
  full_name = var.REPO_PATH
}

resource "github_actions_secret" "AWS_ECR_URL" {
  repository      = data.github_repository.this.name
  secret_name     = "AWS_ECR_URL"
  plaintext_value = aws_ecr_repository.garden-of-intelligence.repository_url
}

resource "github_actions_secret" "AWS_IAM_ROLE_ARN" {
  repository      = data.github_repository.this.name
  secret_name     = "AWS_IAM_ROLE_ARN"
  plaintext_value = aws_iam_role.repo.arn
}

data "aws_region" "current" {}

resource "github_actions_secret" "AWS_REGION" {
  repository      = data.github_repository.this.name
  secret_name     = "AWS_REGION"
  plaintext_value = data.aws_region.current.name
}

resource "github_actions_secret" "DATABASE_URL" {
  repository      = data.github_repository.this.name
  secret_name     = "DATABASE_URL"
  plaintext_value = "postgresql://${aws_db_instance.garden-of-intelligence.username}:${aws_db_instance.garden-of-intelligence.password}@${aws_db_instance.garden-of-intelligence.address}/${aws_db_instance.garden-of-intelligence.db_name}"
}

# Configuration for allowing github actions to communicate with AWS

# This is already setup on the shared aws account
data "aws_iam_openid_connect_provider" "github_actions" {
  url = "https://token.actions.githubusercontent.com"
}

resource "aws_iam_role" "repo" {
  name = "github-actions-${var.APP_NAME}"

  assume_role_policy = data.aws_iam_policy_document.repo-assume-role.json
}

data "aws_iam_policy_document" "repo-assume-role" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [data.aws_iam_openid_connect_provider.github_actions.arn]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:${var.REPO_PATH}:*"]
    }
  }
}

resource "aws_iam_role_policy" "repo-ecr-upload" {
  role   = aws_iam_role.repo.name
  name   = "ecr-${var.APP_NAME}-ci-upload"
  policy = data.aws_iam_policy_document.repo-ecr-upload.json
}

data "aws_iam_policy_document" "repo-ecr-upload" {
  statement {
    actions = [
      "ecr:PutImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
    ]

    resources = [aws_ecr_repository.garden-of-intelligence.arn]
  }
}

resource "aws_iam_role_policy" "repo-ecr-auth" {
  role   = aws_iam_role.repo.name
  name   = "ecr-${var.APP_NAME}-ci-auth"
  policy = data.aws_iam_policy_document.repo-ecr-auth.json
}

data "aws_iam_policy_document" "repo-ecr-auth" {
  statement {
    actions = [
      "ecr:GetAuthorizationToken",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "rds-garden-full-access" {
  role   = aws_iam_role.repo.name
  name   = "rds-${var.APP_NAME}-full-access"
  policy = data.aws_iam_policy_document.rds-garden-full-access.json
}
