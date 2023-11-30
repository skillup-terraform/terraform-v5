
resource "aws_security_group" "terra-sg-01" {
  name = "terra-sg-today-02"
  description = "today class"
  vpc_id = ""
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "test"
    from_port = 80
    to_port = 80
    protocol = "tcp"
  }

  egress{
    cidr_blocks = ["0.0.0.0/0"]
    description = "test"
    from_port = 80
    to_port = 80
    protocol = "tcp"
  }

}

resource "aws_instance" "ec2_test-01" {
  ami = "ami-074dc0a6f6c764218"
  instance_type = "t2.micro"
  subnet_id = "subnet-00d2838782fa3ecee"
  vpc_security_group_ids = ["sg-075d9dc319f0a8390"]
}

