# ---------------------------------------------------------------------------------------------------------------------
# GITHUB REPOSITORY
# ---------------------------------------------------------------------------------------------------------------------

# Learnings:
# - with 'data' you refer to existing resources
# - to allow github actions to communicate with AWS you need to authenticate with an iam role
# - to avoid broad permissions and follow principle of least privilege you can use aws cloud trail, 
#   you find the corresponding logs of API requests via github actions with the role-session-name set in the CI
# - An AWS trust policy establishes the trust relationship between an IAM role and the entities that can assume that role. 
#   When an entity assumes an IAM role, it temporarily acquires the permissions associated with that role. 
#   This is commonly used to grant permissions to services, applications, or users from different AWS accounts or services, 
#   enabling them to access resources securely. 

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

