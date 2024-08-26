resource "aws_launch_template" "example" {
  name          = "example-template-${terraform.workspace}-${random_string.suffix.id}"
  image_id      = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name

  network_interfaces {
    associate_public_ip_address = true
    subnet_id                   = aws_subnet.main_subnet[0].id
    security_groups             = [aws_security_group.web_sg.id]
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "FirstInstance-${terraform.workspace}-${random_string.suffix.id}"
    }
  }

  user_data = base64encode(data.template_file.user_data_hw.rendered)
}
