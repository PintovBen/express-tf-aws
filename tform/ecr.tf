provider "aws" {
  region  = "eu-central-1"
  profile = "ben"
}

resource "aws_ecr_repository" "ecr_repo" {
  name = "ecr_example_repo"
}