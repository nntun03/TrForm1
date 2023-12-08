output "pub-ip-of-demo-server" {
  description = "this is the pub IP"
  value = aws_instance.demo-server.public_ip
}

output "priv-ip-of-demo-server" {
  description = "this is the pub IP"
  value = aws_instance.demo-server.private_ip
}