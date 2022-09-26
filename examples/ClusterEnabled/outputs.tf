output "cluster_enabled_redis_id" {
  description = "ID of the \"cluster-enabled\" replication group."
  value       = module.redis_cluster_enabled.cluster_enabled_redis_id
}

output "cluster_enabled_redis_arn" {
  description = "ARN of the \"cluster-enabled\" replication group."
  value       = module.redis_cluster_enabled.cluster_enabled_redis_arn
}

output "cluster_enabled_redis_engine_version" {
  description = "Actual engine version of the \"cluster-enabled\" replication group."
  value       = module.redis_cluster_enabled.cluster_enabled_redis_engine_version
}

output "cluster_enabled_redis_cluster_enabled" {
  description = "Cluster status of the \"cluster-enabled\" replication group."
  value       = module.redis_cluster_enabled.cluster_enabled_redis_cluster_enabled
}

output "cluster_enabled_redis_config_endpoint" {
  description = "Configuration endpoint address of the \"cluster-enabled\" replication group."
  value       = module.redis_cluster_enabled.cluster_enabled_redis_config_endpoint
}

output "cluster_enabled_redis_member_clusters" {
  description = "Member clusters of the \"cluster-enabled\" replication group."
  value       = module.redis_cluster_enabled.cluster_enabled_redis_member_clusters
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
