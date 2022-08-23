output "cluster_enabled_replication_group_id" {
  description = "ID of the \"cluster-enabled\" replication group."
  value       = aws_elasticache_replication_group.replication_group_cluster_enabled.id
}

output "cluster_enabled_replication_group_arn" {
  description = "ARN of the \"cluster-enabled\" replication group."
  value       = aws_elasticache_replication_group.replication_group_cluster_enabled.arn
}

output "cluster_enabled_replication_group_engine_version" {
  description = "Actual engine version of the \"cluster-enabled\" replication group."
  value       = aws_elasticache_replication_group.replication_group_cluster_enabled.engine_version_actual
}

output "cluster_enabled_replication_group_cluster_enabled" {
  description = "Cluster status of the \"cluster-enabled\" replication group."
  value       = aws_elasticache_replication_group.replication_group_cluster_enabled.cluster_enabled
}

output "cluster_enabled_replication_group_config_endpoint" {
  description = "Configuration endpoint address of the \"cluster-enabled\" replication group."
  value       = aws_elasticache_replication_group.replication_group_cluster_enabled.configuration_endpoint_address
}

output "cluster_enabled_replication_group_member_clusters" {
  description = "Member clusters of the \"cluster-enabled\" replication group."
  value       = aws_elasticache_replication_group.replication_group_cluster_enabled.member_clusters
}

output "cluster_enabled_replication_group_primary_endpoint" {
  description = "Primary endpoint address of the \"cluster-enabled\" replication group."
  value       = aws_elasticache_replication_group.replication_group_cluster_enabled.primary_endpoint_address
}

output "cluster_enabled_replication_group_reader_endpoint" {
  description = "Reader endpoint address of the \"cluster-enabled\" replication group."
  value       = aws_elasticache_replication_group.replication_group_cluster_enabled.reader_endpoint_address
}
