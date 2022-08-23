output "cluster_disabled_replication_group_id" {
  description = "ID of the \"cluster-disabled\" replication group."
  value       = module.redis_cluster_disabled.cluster_disabled_replication_group_id
}

output "cluster_disabled_replication_group_arn" {
  description = "ARN of the \"cluster-disabled\" replication group."
  value       = module.redis_cluster_disabled.cluster_disabled_replication_group_arn
}

output "cluster_disabled_replication_group_engine_version" {
  description = "Actual engine version of the \"cluster-disabled\" replication group."
  value       = module.redis_cluster_disabled.cluster_disabled_replication_group_engine_version
}

output "cluster_disabled_replication_group_cluster_enabled" {
  description = "Cluster status of the \"cluster-disabled\" replication group."
  value       = module.redis_cluster_disabled.cluster_disabled_replication_group_cluster_enabled
}

output "cluster_disabled_replication_group_config_endpoint" {
  description = "Configuration endpoint address of the \"cluster-disabled\" replication group."
  value       = module.redis_cluster_disabled.cluster_disabled_replication_group_config_endpoint
}

output "cluster_disabled_replication_group_member_clusters" {
  description = "Member clusters of the \"cluster-disabled\" replication group."
  value       = module.redis_cluster_disabled.cluster_disabled_replication_group_member_clusters
}

output "cluster_disabled_replication_group_primary_endpoint" {
  description = "Primary endpoint address of the \"cluster-disabled\" replication group."
  value       = module.redis_cluster_disabled.cluster_disabled_replication_group_primary_endpoint
}

output "cluster_disabled_replication_group_reader_endpoint" {
  description = "Reader endpoint address of the \"cluster-disabled\" replication group."
  value       = module.redis_cluster_disabled.cluster_disabled_replication_group_reader_endpoint
}

output "cluster_disabled_cache_nodes" {
  description = "Cache nodes of the \"cluster-disabled\" cluster_mode."
  value       = module.redis_cluster_disabled.cluster_disabled_cache_nodes
}
