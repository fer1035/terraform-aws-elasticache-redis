module "network" {
  source  = "app.terraform.io/fer1035/network/aws"
}

module "security-group" {
  source  = "app.terraform.io/fer1035/security-group/aws"
  
  vpc_id            = module.network.vpc_id
  ingress_from      = 6379
  ingress_to        = 6379
  ingress_protocol  = "tcp"
  ingress_cidr      = "0.0.0.0/0"
  ingress_cidr_ipv6 = "::/0"
  sg_description    = "Redis"
}

module "elasticache-redis" {
  source  = "app.terraform.io/fer1035/elasticache-redis/aws"

  redis_subnet_ids = [module.network.private_subnet_1, module.network.private_subnet_2]
  redis_sgids      = [module.security-group.security_group_id]
}

output "cluster_disabled_redis_id" {
  description = "ID of the \"cluster-disabled\" replication group."
  value       = module.elasticache-redis.cluster_disabled_redis_id
}

output "cluster_disabled_redis_arn" {
  description = "ARN of the \"cluster-disabled\" replication group."
  value       = module.elasticache-redis.cluster_disabled_redis_arn
}

output "cluster_disabled_redis_engine_version" {
  description = "Actual engine version of the \"cluster-disabled\" replication group."
  value       = module.elasticache-redis.cluster_disabled_redis_engine_version
}

output "cluster_disabled_redis_cluster_enabled" {
  description = "Cluster status of the \"cluster-disabled\" replication group."
  value       = module.elasticache-redis.cluster_disabled_redis_cluster_enabled
}

output "cluster_disabled_redis_member_clusters" {
  description = "Member clusters of the \"cluster-disabled\" replication group."
  value       = module.elasticache-redis.cluster_disabled_redis_member_clusters
}

output "cluster_disabled_redis_primary_endpoint" {
  description = "Primary endpoint address of the \"cluster-disabled\" replication group."
  value       = module.elasticache-redis.cluster_disabled_redis_primary_endpoint
}

output "cluster_disabled_redis_reader_endpoint" {
  description = "Reader endpoint address of the \"cluster-disabled\" replication group."
  value       = module.elasticache-redis.cluster_disabled_redis_reader_endpoint
}

output "cluster_disabled_cache_nodes" {
  description = "Cache nodes of the \"cluster-disabled\" cluster_mode."
  value       = module.elasticache-redis.cluster_disabled_cache_nodes
}

output "redis_port" {
  description = "Redis connection port."
  value       = module.elasticache-redis.redis_port
}

output "slow_logs" {
  description = "CloudWatch Logs group for the Redis application."
  value       = module.elasticache-redis.slow_logs
}

output "engine_logs" {
  description = "CloudWatch Logs group for the Redis engine."
  value       = module.elasticache-redis.engine_logs
}

output "sns_topic" {
  description = "SNS notification topic for the Redis application."
  value       = module.elasticache-redis.sns_topic
}
