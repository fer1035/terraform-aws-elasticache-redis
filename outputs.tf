output "redis_port" {
  description = "Redis connection port."
  value       = var.redis_port
}

output "log_group" {
  description = "CloudWatch Logs group for the Redis application."
  value       = aws_cloudwatch_log_group.log_group.arn
}

output "sns_topic" {
  description = "SNS notification topic for the Redis application."
  value       = aws_sns_topic.topic.arn
}
