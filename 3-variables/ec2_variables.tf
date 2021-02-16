provider "aws" {
  region     = "us-west-2"
}

resource "aws_instance" "myec2" {
   ami = "ami-0e999cbd62129e3b1"
   instance_type = var.instance_type
}

resource "aws_iam_user" "iam_user" {
    name = var.user_number
    path = "/system/"
}