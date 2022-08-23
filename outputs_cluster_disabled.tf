output "cluster_disabled_replication_group_id" {
  description = "ID of the \"cluster-disabled\" replication group."
  value       = length(aws_elasticache_replication_group.replication_group_cluster_disabled) > 0 ? aws_elasticache_replication_group.replication_group_cluster_disabled[*].id : null
}

output "cluster_disabled_replication_group_arn" {
  description = "ARN of the \"cluster-disabled\" replication group."
  value       = length(aws_elasticache_replication_group.replication_group_cluster_disabled) > 0 ? aws_elasticache_replication_group.replication_group_cluster_disabled[*].arn : null
}

output "cluster_disabled_replication_group_engine_version" {
  description = "Actual engine version of the \"cluster-disabled\" replication group."
  value       = length(aws_elasticache_replication_group.replication_group_cluster_disabled) > 0 ? aws_elasticache_replication_group.replication_group_cluster_disabled[*].engine_version_actual : null
}

output "cluster_disabled_replication_group_cluster_enabled" {
  description = "Cluster status of the \"cluster-disabled\" replication group."
  value       = length(aws_elasticache_replication_group.replication_group_cluster_disabled) > 0 ? aws_elasticache_replication_group.replication_group_cluster_disabled[*].cluster_enabled : null
}

output "cluster_disabled_replication_group_config_endpoint" {
  description = "Configuration endpoint address of the \"cluster-disabled\" replication group."
  value       = length(aws_elasticache_replication_group.replication_group_cluster_disabled) > 0 ? aws_elasticache_replication_group.replication_group_cluster_disabled[*].configuration_endpoint_address : null
}

output "cluster_disabled_replication_group_member_clusters" {
  description = "Member clusters of the \"cluster-disabled\" replication group."
  value       = length(aws_elasticache_replication_group.replication_group_cluster_disabled) > 0 ? aws_elasticache_replication_group.replication_group_cluster_disabled[*].member_clusters : null
}

output "cluster_disabled_replication_group_primary_endpoint" {
  description = "Primary endpoint address of the \"cluster-disabled\" replication group."
  value       = length(aws_elasticache_replication_group.replication_group_cluster_disabled) > 0 ? aws_elasticache_replication_group.replication_group_cluster_disabled[*].primary_endpoint_address : null
}

output "cluster_disabled_replication_group_reader_endpoint" {
  description = "Reader endpoint address of the \"cluster-disabled\" replication group."
  value       = length(aws_elasticache_replication_group.replication_group_cluster_disabled) > 0 ? aws_elasticache_replication_group.replication_group_cluster_disabled[*].reader_endpoint_address : null
}

output "cluster_disabled_cache_nodes" {
  description = "Cache nodes of the \"cluster-disabled\" cluster_mode."
  value       = length(aws_elasticache_cluster.cluster_disabled) > 0 ? aws_elasticache_cluster.cluster_disabled[*].cache_nodes : null
}
