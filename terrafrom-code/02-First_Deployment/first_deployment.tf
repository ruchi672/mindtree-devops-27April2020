provider "aws" {
  region     = "us-east-2"
}

resource "aws_instance" "example" {
  ami           = "ami-03ffa9b61e8d2cfda"
  instance_type = "t2.micro"
}
