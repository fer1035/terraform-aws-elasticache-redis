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
