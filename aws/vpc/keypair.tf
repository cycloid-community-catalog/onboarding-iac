resource "aws_key_pair" "infra" {
  count = var.bastion_instance ? 1 : 0

  key_name   = "${var.customer}-${var.project}-${var.env}-infra-key"
  public_key = var.keypair_public
}