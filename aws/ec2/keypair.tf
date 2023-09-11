resource "aws_key_pair" "webapp" {
  count = var.keypair_public ? 1 : 0
  
  key_name   = "${var.customer}-${var.project}-${var.env}-webapp"
  public_key = var.keypair_public
}