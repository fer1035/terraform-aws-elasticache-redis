resource "aws_elasticache_cluster" "cluster_instance" {
  count = var.cluster_mode == "instance" ? 1 : 0

  availability_zone         = var.redis_cluster_azs != null ? var.redis_cluster_azs[0] : null
  cluster_id                = var.redis_id
  final_snapshot_identifier = "${var.redis_final_snapshot_name}-instance-final-snapshot"
  node_type                 = var.redis_node_type
  notification_topic_arn    = aws_sns_topic.topic.arn
  num_cache_nodes           = 1
  parameter_group_name      = aws_elasticache_parameter_group.parameter_group_nocluster[0].name
  engine                    = var.redis_engine_type
  engine_version            = var.redis_engine_version
  snapshot_retention_limit  = var.redis_snapshot_retention_limit
  port                      = var.redis_port
  security_group_ids        = var.redis_sgids
  subnet_group_name         = length(aws_elasticache_subnet_group.subnet_group) > 0 ? aws_elasticache_subnet_group.subnet_group.name : null

  apply_immediately          = var.redis_apply_immediately
  auto_minor_version_upgrade = var.redis_auto_minor_version_upgrade
  maintenance_window         = var.redis_maintenance_window
  snapshot_window            = var.redis_snapshot_window

  log_delivery_configuration {
    destination       = aws_cloudwatch_log_group.log_group.name
    destination_type  = "cloudwatch-logs"
    log_format        = "text"
    log_type          = "slow-log"
  }
}

/* resource "aws_elasticache_cluster" "cluster_disabled" {
  count = var.cluster_mode == "cluster-disabled" ? 1 : 0

  cluster_id           = "${aws_elasticache_replication_group.redis_cluster_disabled[0].replication_group_id}-${count.index}"
  replication_group_id = aws_elasticache_replication_group.redis_cluster_disabled[0].replication_group_id

  log_delivery_configuration {
    destination       = aws_cloudwatch_log_group.log_group.name
    destination_type  = "cloudwatch-logs"
    log_format        = "text"
    log_type          = "slow-log"
  }
} */
