output "load_balancer_dns" {
  value       = aws_lb.mein_lb.dns_name
  description = "DNS name of the load balancer"
}
output "instanceIPv4" {
  value       = aws_instance.firstinstance.public_ip
  description = "Public IP address of the instance"
}

