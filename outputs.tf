output "redis_port" {
  description = "Redis connection port."
  value       = var.redis_port
}

output "slow_logs" {
  description = "CloudWatch Logs group for the Redis application."
  value       = aws_cloudwatch_log_group.slow_logs.arn
}

output "engine_logs" {
  description = "CloudWatch Logs group for the Redis engine."
  value       = aws_cloudwatch_log_group.engine_logs.arn
}

output "sns_topic" {
  description = "SNS notification topic for the Redis application."
  value       = aws_sns_topic.topic.arn
}
