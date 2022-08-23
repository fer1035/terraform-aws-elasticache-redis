resource "aws_elasticache_cluster" "cluster_instance" {
  count = var.cluster_mode == "instance" ? 1 : 0

  availability_zone         = var.replication_group_cluster_azs[0]
  cluster_id                = var.replication_group_id
  final_snapshot_identifier = "${var.replication_group_id}-final-snapshot"
  node_type                 = var.replication_group_node_type
  notification_topic_arn    = aws_sns_topic.topic.arn
  num_cache_nodes           = 1
  parameter_group_name      = aws_elasticache_parameter_group.parameter_group_nocluster[0].name
  engine                    = var.replication_group_engine_type
  engine_version            = var.replication_group_engine_version
  snapshot_retention_limit  = var.replication_group_snapshot_retention_limit
  port                      = var.replication_group_port
  security_group_ids        = var.replication_group_sgids
  subnet_group_name         = aws_elasticache_subnet_group.subnet_group.name

  apply_immediately          = var.replication_group_apply_immediately
  auto_minor_version_upgrade = var.replication_group_auto_minor_version_upgrade
  maintenance_window         = var.replication_group_maintenance_window
  snapshot_window            = var.replication_group_snapshot_window
}

resource "aws_elasticache_cluster" "cluster_disabled" {
  count = var.cluster_mode == "cluster-disabled" ? 1 : 0

  cluster_id           = "${aws_elasticache_replication_group.replication_group_cluster_disabled[0].replication_group_id}-${count.index}"
  replication_group_id = aws_elasticache_replication_group.replication_group_cluster_disabled[0].replication_group_id
}
