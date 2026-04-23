output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}

output "alb_dns_name" {
  value       = aws_lb.ai_alb.dns_name
  description = "The DNS name of the ALB to access the inference endpoint"
}

output "endpoint_url" {
  value = "http://${aws_lb.ai_alb.dns_name}/v1/chat/completions"
}

output "cpu_node_private_ip" {
  value = aws_instance.gpu_node.private_ip
}

output "curl_test_command" {
  description = "Copy-paste this command to test your AI endpoint"
  value       = <<-EOT
    curl -X POST http://${aws_lb.ai_alb.dns_name}/v1/chat/completions \
      -H "Content-Type: application/json" \
      -d '{"model": "tinyllama", "messages": [{"role": "user", "content": "Hello, who are you?"}]}'
  EOT
}