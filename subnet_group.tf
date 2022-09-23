resource "aws_elasticache_subnet_group" "subnet_group" {
  count = var.redis_subnet_ids != null ? 1 : 0

  name        = var.redis_id
  description = var.description
  subnet_ids  = var.redis_subnet_ids
}
