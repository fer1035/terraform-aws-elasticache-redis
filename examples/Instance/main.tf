module "redis_instance" {
  source                       = "app.terraform.io/fer1035/elasticache-redis/aws"
  replication_group_subnet_ids = ["subnet-01234567890abcdef"]
}
