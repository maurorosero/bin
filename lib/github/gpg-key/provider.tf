# MROSERO TOOLBOX [TERRAFORM PROVIDERS - SET GPG GITHUB]
# Created Date: 2024-06-03
# Modified Date: 2024-06-03 14:33 TZ-5

terraform {
  required_providers {
    github = {
      source = "integrations/github"
      version = "6.2.1"
    }
  }
}


provider "github" {
  token = var.GITHUB_TOKEN
}
