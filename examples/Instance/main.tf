module "redis_instance" {
  source                       = "app.terraform.io/fer1035/elasticache-redis/aws"
  redis_subnet_ids = ["subnet-01234567890abcdef"]
}
