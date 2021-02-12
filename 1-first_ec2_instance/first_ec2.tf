provider "aws" {
  region     = "us-west-2"
}

resource "aws_instance" "myec2" {
   ami = "ami-0e999cbd62129e3b1"
   instance_type = "t2.micro"
}
