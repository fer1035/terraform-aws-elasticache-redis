output "instance_arn" {
  description = "ARN of the \"instance\" cluster_mode."
  value       = aws_elasticache_cluster.cluster_instance[count.index].arn
}

output "instance_actual_engine_version" {
  description = "Actual engine version of the \"instance\" cluster_mode."
  value       = aws_elasticache_cluster.cluster_instance[count.index].engine_version_actual
}

output "instance_cache_nodes" {
  description = "Cache nodes of the \"instance\" cluster_mode."
  value       = aws_elasticache_cluster.cluster_instance[count.index].cache_nodes
}
