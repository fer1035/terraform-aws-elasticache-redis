output "instance_arn" {
  description = "ARN of the \"instance\" cluster_mode."
  value       = length(aws_elasticache_cluster.cluster_instance) > 0 ? aws_elasticache_cluster.cluster_instance[*].arn : null
}

output "instance_actual_engine_version" {
  description = "Actual engine version of the \"instance\" cluster_mode."
  value       = length(aws_elasticache_cluster.cluster_instance) > 0 ? aws_elasticache_cluster.cluster_instance[*].engine_version_actual : null
}

output "instance_cache_nodes" {
  description = "Cache nodes of the \"instance\" cluster_mode."
  value       = length(aws_elasticache_cluster.cluster_instance) > 0 ? aws_elasticache_cluster.cluster_instance[*].cache_nodes : null
}
