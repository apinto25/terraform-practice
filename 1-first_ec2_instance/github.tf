terraform {
  required_providers {
    github = {
      source = "integrations/github"
      version = "4.3.2"
    }
  }
}

provider "github" {
  token = "github_token"
}

resource "github_repository" "terraform-repo" {
  name        = "terraform-example-repo"
  visibility  = "private"
}
