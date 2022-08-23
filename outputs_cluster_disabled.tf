output "cluster_disabled_replication_group_id" {
  description = "ID of the \"cluster-disabled\" replication group."
  value       = aws_elasticache_replication_group.replication_group_cluster_disabled[0].id
}

output "cluster_disabled_replication_group_arn" {
  description = "ARN of the \"cluster-disabled\" replication group."
  value       = aws_elasticache_replication_group.replication_group_cluster_disabled[0].arn
}

output "cluster_disabled_replication_group_engine_version" {
  description = "Actual engine version of the \"cluster-disabled\" replication group."
  value       = aws_elasticache_replication_group.replication_group_cluster_disabled[0].engine_version_actual
}

output "cluster_disabled_replication_group_cluster_enabled" {
  description = "Cluster status of the \"cluster-disabled\" replication group."
  value       = aws_elasticache_replication_group.replication_group_cluster_disabled[0].cluster_enabled
}

output "cluster_disabled_replication_group_config_endpoint" {
  description = "Configuration endpoint address of the \"cluster-disabled\" replication group."
  value       = aws_elasticache_replication_group.replication_group_cluster_disabled[0].configuration_endpoint_address
}

output "cluster_disabled_replication_group_member_clusters" {
  description = "Member clusters of the \"cluster-disabled\" replication group."
  value       = aws_elasticache_replication_group.replication_group_cluster_disabled[0].member_clusters
}

output "cluster_disabled_replication_group_primary_endpoint" {
  description = "Primary endpoint address of the \"cluster-disabled\" replication group."
  value       = aws_elasticache_replication_group.replication_group_cluster_disabled[0].primary_endpoint_address
}

output "cluster_disabled_replication_group_reader_endpoint" {
  description = "Reader endpoint address of the \"cluster-disabled\" replication group."
  value       = aws_elasticache_replication_group.replication_group_cluster_disabled[0].reader_endpoint_address
}

output "cluster_disabled_cache_nodes" {
  description = "Cache nodes of the \"cluster-disabled\" cluster_mode."
  value       = aws_elasticache_cluster.cluster_disabled[0].cache_nodes
}
