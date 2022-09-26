provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      Name = "Redis-Cluster-Enabled"
    }
  }
}

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

  cluster_mode        = "cluster-enabled"
  redis_multi_az      = true
  autoscaling_enabled = true
  redis_subnet_ids    = [module.network.private_subnet_1, module.network.private_subnet_2]
  redis_sgids         = [module.security-group.security_group_id]
}
