output "cluster_enabled_redis_id" {
  description = "ID of the \"cluster-enabled\" replication group."
  value       = length(aws_elasticache_replication_group.redis_cluster_enabled) > 0 ? aws_elasticache_replication_group.redis_cluster_enabled[*].id : null
}

output "cluster_enabled_redis_arn" {
  description = "ARN of the \"cluster-enabled\" replication group."
  value       = length(aws_elasticache_replication_group.redis_cluster_enabled) > 0 ? aws_elasticache_replication_group.redis_cluster_enabled[*].arn : null
}

output "cluster_enabled_redis_engine_version" {
  description = "Actual engine version of the \"cluster-enabled\" replication group."
  value       = length(aws_elasticache_replication_group.redis_cluster_enabled) > 0 ? aws_elasticache_replication_group.redis_cluster_enabled[*].engine_version_actual : null
}

output "cluster_enabled_redis_cluster_enabled" {
  description = "Cluster status of the \"cluster-enabled\" replication group."
  value       = length(aws_elasticache_replication_group.redis_cluster_enabled) > 0 ? aws_elasticache_replication_group.redis_cluster_enabled[*].cluster_enabled : null
}

output "cluster_enabled_redis_config_endpoint" {
  description = "Configuration endpoint address of the \"cluster-enabled\" replication group."
  value       = length(aws_elasticache_replication_group.redis_cluster_enabled) > 0 ? aws_elasticache_replication_group.redis_cluster_enabled[*].configuration_endpoint_address : null
}

output "cluster_enabled_redis_member_clusters" {
  description = "Member clusters of the \"cluster-enabled\" replication group."
  value       = length(aws_elasticache_replication_group.redis_cluster_enabled) > 0 ? aws_elasticache_replication_group.redis_cluster_enabled[*].member_clusters : null
}
