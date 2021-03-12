provider "aws" {
  region     = "us-west-2"
}

locals {
  # Common tags to be assigned to all resources
  common_tags = {
    Service = "backend"
    Owner   = "Devops team"
  }
}

resource "aws_instance" "app-dev" {
  ami           = "ami-0e999cbd62129e3b1"
  instance_type = "t2.micro"
  tags          = local.common_tags
}

resource "aws_instance" "db-dev" {
  ami           = "ami-0e999cbd62129e3b1"
  instance_type = "t2.micro"
  tags          = local.common_tags
}
