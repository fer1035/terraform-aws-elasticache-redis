resource "aws_elasticache_subnet_group" "subnet_group" {
  name        = var.redis_id
  description = var.description
  subnet_ids  = var.redis_subnet_ids
}
