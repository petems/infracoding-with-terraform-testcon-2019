resource "aws_instance" "foobar" {
  ami           = "ami-03ef731cc103c9f09" // eu-west-1 Ubuntu 16.04
  instance_type = "c5.metal"

  tags = {
    Name = "foobar"
    DemoDate = "14-October-2019"
  }
}

output "instance_type" {
  value = "${aws_instance.foobar.instance_type}"
}
