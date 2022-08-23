resource "aws_elasticache_subnet_group" "subnet_group" {
  name        = var.replication_group_id
  description = var.description
  subnet_ids  = var.replication_group_subnet_ids
}
