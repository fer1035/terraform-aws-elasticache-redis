output "instance_arn" {
  description = "ARN of the \"instance\" cluster_mode."
  value       = module.redis_instance.instance_arn
}

output "instance_actual_engine_version" {
  description = "Actual engine version of the \"instance\" cluster_mode."
  value       = module.redis_instance.instance_actual_engine_version
}

output "instance_cache_nodes" {
  description = "Cache nodes of the \"instance\" cluster_mode."
  value       = module.redis_instance.instance_cache_nodes
}

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
