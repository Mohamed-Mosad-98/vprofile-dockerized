output "alb_dns_name" {
  value = aws_lb.this.dns_name
}

output "alb_arn" {
  value = aws_lb.this.arn
}

output "java_target_group_arn" {
  value = aws_lb_target_group.java.arn
}

output "nginx_target_group_arn" {
  value = aws_lb_target_group.nginx.arn
}