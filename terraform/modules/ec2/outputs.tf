output "instance_id" {
  value = aws_instance.docker_host.id
}

output "private_ip" {
  value = aws_instance.docker_host.private_ip
}

output "availability_zone" {
  value = aws_instance.docker_host.availability_zone
}