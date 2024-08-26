resource "aws_instance" "firstinstance" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  subnet_id     = aws_subnet.main_subnet[0].id

  user_data = data.template_file.user_data_hw.rendered

  tags = {
    Name = "Main Instance"
  }
}

resource "aws_lb_target_group_attachment" "main_instance_attachment" {
  target_group_arn = aws_lb_target_group.web_target_group.arn
  target_id        = aws_instance.firstinstance.id
  port             = 80
}
