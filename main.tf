resource "aws_key_pair" "example_key" {
  count = var.create_key_pair ? 1 : 0
  key_name   = "example-key"
  public_key = file("~/.ssh/id_rsa.pub")  # Replace with your public key file
}

resource "aws_instance" "example_instance" {
  ami           = "ami-09ac7e749b0a8d2a1"  # Replace with your desired AMI ID
  instance_type = "t2.micro"  # Replace with your desired instance type
  key_name      =  var.create_key_pair ? aws_key_pair.example_key[0].key_name : var.key_pair_to_use


  tags = {
    Name = "ExampleInstance"
  }
}

output "instance_public_ip" {
  value = aws_instance.example_instance.public_ip
}

variable "key_pair_to_use" {
  type    = string
  default = "testkey1" # Optional, you can specify a default value
}

variable "create_key_pair" {
  type    = bool
  default = true
}


