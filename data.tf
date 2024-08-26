data "template_file" "user_data_hw" {
  template = <<EOF
#!/bin/bash
sudo yum update -y
sleep 30

sudo yum install -y httpd
sleep 30

sudo systemctl start httpd
sleep 5

sudo systemctl enable httpd
sleep 5

if ! sudo systemctl is-active --quiet httpd; then
  sudo systemctl restart httpd
  sleep 20
fi

# Erstelle die Hello World Seite
echo "<h1>Hello World</h1>" | sudo tee /var/www/html/index.html
EOF
}
