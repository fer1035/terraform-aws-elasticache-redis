provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      Name = "Redis-Cluster-Disabled"
    }
  }
}

module "elasticache-redis" {
  source  = "app.terraform.io/fer1035/elasticache-redis/aws"

  cluster_mode        = "cluster-enabled"
  redis_multi_az      = true
  autoscaling_enabled = true
  redis_subnet_ids    = ["subnet-1234567890", "subnet-0987654321"]
  redis_sgids         = ["sg-1234567890"]
}
