resource "aws_security_group" "ec2" {
  name        = "${var.customer}-${var.project}-${var.env}-ec2"
  description = "Allow accessing the instance from the internet."
  vpc_id      = data.aws_subnet.selected.vpc_id

  tags = merge(local.merged_tags, {
    Name       = "${var.customer}-${var.project}-${var.env}-ec2"
  })
}

resource "aws_security_group_rule" "egress-all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ec2.id
}

resource "aws_security_group_rule" "ingress-ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ec2.id
}

resource "aws_security_group_rule" "ingress-http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ec2.id
}

resource "aws_security_group_rule" "ingress-https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ec2.id
}

resource "aws_instance" "ec2" {
  ami           = data.aws_ami.debian.id
  instance_type = var.vm_instance_type
  key_name      = aws_key_pair.ec2.key_name

  vpc_security_group_ids = [aws_security_group.ec2.id]

  subnet_id               = var.subnet_id
  disable_api_termination = false
  associate_public_ip_address = var.associate_public_ip_address

  root_block_device {
    volume_size           = var.vm_disk_size
    delete_on_termination = true
  }

  tags = merge(local.merged_tags, {
    Name = "${var.customer}-${var.project}-${var.env}"
    role = "ec2"
  })

  lifecycle {
    ignore_changes = [ami]
  }
}
