resource "aws_key_pair" "deployer" {
  key_name   = "deploy"
  public_key = "${file("/home/shashankt/.ssh/id_rsa.pub")}"
}