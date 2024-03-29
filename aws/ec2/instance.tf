resource "aws_security_group" "ec2_security_group" {
  name        = "${var.customer}-${var.project}-${var.env}"
  description = "Allow accessing the instance from the internet."
  vpc_id      = data.aws_subnet.selected.vpc_id

  dynamic "ingress" {
    for_each = var.service_ports
    content {
      from_port = ingress.value
      to_port   = ingress.value
      protocol  = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = merge(local.merged_tags, {
    Name = "${var.customer}-${var.project}-${var.env}"
    role = "security_group"
  })
}

resource "aws_instance" "ec2" {
  ami           = data.aws_ami.debian.id
  instance_type = var.vm_instance_type
  key_name      = var.key_pair_name

  vpc_security_group_ids = [aws_security_group.ec2_security_group.id]

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
