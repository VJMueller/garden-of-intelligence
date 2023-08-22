# ---------------------------------------------------------------------------------------------------------------------
# PROVIDER
# ---------------------------------------------------------------------------------------------------------------------

# Learnings:
# - https://developer.hashicorp.com/terraform/language/providers
# - Terraform providers are plugins that enable Terraform to interact with and manage specific infrastructure platforms or services,
#   allowing users to define and deploy their desired infrastructure configurations.
# - both aws and github provider need additional configuration

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.22.0"
    }

    github = {
      source  = "integrations/github"
      version = "5.32.0"
    }
  }
}

provider "aws" {
  region  = "eu-west-1"
  profile = "sandbox"
}

provider "github" {
  token = var.GITHUB_TOKEN
}
