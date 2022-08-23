output "cluster_enabled_replication_group_id" {
  description = "ID of the \"cluster-enabled\" replication group."
  value       = length(aws_elasticache_replication_group.replication_group_cluster_enabled) > 0 ? aws_elasticache_replication_group.replication_group_cluster_enabled[*].id : null
}

output "cluster_enabled_replication_group_arn" {
  description = "ARN of the \"cluster-enabled\" replication group."
  value       = length(aws_elasticache_replication_group.replication_group_cluster_enabled) > 0 ? aws_elasticache_replication_group.replication_group_cluster_enabled[*].arn : null
}

output "cluster_enabled_replication_group_engine_version" {
  description = "Actual engine version of the \"cluster-enabled\" replication group."
  value       = length(aws_elasticache_replication_group.replication_group_cluster_enabled) > 0 ? aws_elasticache_replication_group.replication_group_cluster_enabled[*].engine_version_actual : null
}

output "cluster_enabled_replication_group_cluster_enabled" {
  description = "Cluster status of the \"cluster-enabled\" replication group."
  value       = length(aws_elasticache_replication_group.replication_group_cluster_enabled) > 0 ? aws_elasticache_replication_group.replication_group_cluster_enabled[*].cluster_enabled : null
}

output "cluster_enabled_replication_group_config_endpoint" {
  description = "Configuration endpoint address of the \"cluster-enabled\" replication group."
  value       = length(aws_elasticache_replication_group.replication_group_cluster_enabled) > 0 ? aws_elasticache_replication_group.replication_group_cluster_enabled[*].configuration_endpoint_address : null
}

output "cluster_enabled_replication_group_member_clusters" {
  description = "Member clusters of the \"cluster-enabled\" replication group."
  value       = length(aws_elasticache_replication_group.replication_group_cluster_enabled) > 0 ? aws_elasticache_replication_group.replication_group_cluster_enabled[*].member_clusters : null
}

output "cluster_enabled_replication_group_primary_endpoint" {
  description = "Primary endpoint address of the \"cluster-enabled\" replication group."
  value       = length(aws_elasticache_replication_group.replication_group_cluster_enabled) > 0 ? aws_elasticache_replication_group.replication_group_cluster_enabled[*].primary_endpoint_address : null
}

output "cluster_enabled_replication_group_reader_endpoint" {
  description = "Reader endpoint address of the \"cluster-enabled\" replication group."
  value       = length(aws_elasticache_replication_group.replication_group_cluster_enabled) > 0 ? aws_elasticache_replication_group.replication_group_cluster_enabled[*].reader_endpoint_address : null
}
