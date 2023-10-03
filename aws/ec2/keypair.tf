resource "aws_key_pair" "ec2" {  
  key_name   = "${var.customer}-${var.project}-${var.env}-ec2"
  public_key = var.keypair_public
}