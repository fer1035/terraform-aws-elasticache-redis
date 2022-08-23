module "redis_cluster_disabled" {
  source                       = "app.terraform.io/fer1035/elasticache-redis/aws"
  cluster_mode                 = "cluster-disabled"
  replication_group_subnet_ids = ["subnet-01234567890abcdef"]
}
