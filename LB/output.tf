output "lb_dns_name0" {
  description = "The dns for lb"
  value       = aws_lb.loadbalancer.0.dns_name
}

output "lb_dns_name1" {
  description = "The dns for lb"
  value       = aws_lb.loadbalancer.1.dns_name
}