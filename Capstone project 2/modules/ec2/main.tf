resource "aws_instance" "this" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_group_ids

  tags = merge(
    {
      "Name" = var.instance_name
    },
    var.additional_tags
  )

  user_data = file("${path.module}/userdata.sh")

  # EBS Block device mapping
  root_block_device {
    volume_size = var.root_volume_size
    volume_type = var.root_volume_type
  }

  lifecycle {
    create_before_destroy = true
  }

  # Enable termination protection
  disable_api_termination = var.disable_api_termination
}