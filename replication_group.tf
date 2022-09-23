resource "aws_elasticache_replication_group" "redis_cluster_disabled" {
  count = var.cluster_mode == "cluster-disabled" ? 1 : 0

  replication_group_id        = "${var.redis_id}-rep-grp"
  description                 = var.description
  node_type                   = var.redis_node_type
  port                        = var.redis_port
  parameter_group_name        = aws_elasticache_parameter_group.parameter_group_nocluster[0].name
  automatic_failover_enabled  = var.redis_failover
  num_cache_clusters          = var.redis_num_cache_clusters
  preferred_cache_cluster_azs = var.redis_cluster_azs
  data_tiering_enabled        = var.redis_data_tiering

  at_rest_encryption_enabled = var.redis_at_rest_encryption
  kms_key_id                 = var.redis_kms_id
  transit_encryption_enabled = var.redis_transit_encryption
  auth_token                 = var.redis_auth_token

  engine                    = var.redis_engine_type
  engine_version            = var.redis_engine_version
  snapshot_retention_limit  = var.redis_snapshot_retention_limit
  final_snapshot_identifier = "${var.redis_final_snapshot_name}-rep-grp-final-snapshot"
  multi_az_enabled          = var.redis_multi_az
  notification_topic_arn    = aws_sns_topic.topic.arn
  security_group_ids        = var.redis_sgids
  subnet_group_name         = length(aws_elasticache_subnet_group.subnet_group) > 0 ? aws_elasticache_subnet_group.subnet_group[0].name : null

  apply_immediately          = var.redis_apply_immediately
  auto_minor_version_upgrade = var.redis_auto_minor_version_upgrade
  maintenance_window         = var.redis_maintenance_window
  snapshot_window            = var.redis_snapshot_window

  lifecycle {
    ignore_changes = [num_cache_clusters]
  }

  log_delivery_configuration {
    destination       = aws_cloudwatch_log_group.log_group.name
    destination_type  = "cloudwatch-logs"
    log_format        = "text"
    log_type          = "slow-log"
  }
  /* log_delivery_configuration {
    destination      = aws_kinesis_firehose_delivery_stream.example.name
    destination_type = "kinesis-firehose"
    log_format       = "json"
    log_type         = "engine-log"
  } */

  timeouts {
    create = "60m"
    delete = "2h"
    update = "40m"
  }
}

resource "aws_elasticache_replication_group" "redis_cluster_enabled" {
  count = var.cluster_mode == "cluster-enabled" ? 1 : 0

  replication_group_id        = "${var.redis_id}-cluster"
  description                 = var.description
  node_type                   = var.redis_node_type
  port                        = var.redis_port
  parameter_group_name        = aws_elasticache_parameter_group.parameter_group_cluster[0].name
  automatic_failover_enabled  = var.redis_failover
  /* preferred_cache_cluster_azs = var.redis_cluster_azs */
  data_tiering_enabled        = var.redis_data_tiering

  num_node_groups         = var.redis_num_node_groups
  replicas_per_node_group = var.redis_num_replicas

  at_rest_encryption_enabled = var.redis_at_rest_encryption
  kms_key_id                 = var.redis_kms_id
  transit_encryption_enabled = var.redis_transit_encryption
  auth_token                 = var.redis_auth_token

  engine                    = var.redis_engine_type
  engine_version            = var.redis_engine_version
  snapshot_retention_limit  = var.redis_snapshot_retention_limit
  final_snapshot_identifier = "${var.redis_final_snapshot_name}-cluster-final-snapshot"
  multi_az_enabled          = var.redis_multi_az
  notification_topic_arn    = aws_sns_topic.topic.arn
  security_group_ids        = var.redis_sgids
  subnet_group_name         = length(aws_elasticache_subnet_group.subnet_group) > 0 ? aws_elasticache_subnet_group.subnet_group[0].name : null

  apply_immediately          = var.redis_apply_immediately
  auto_minor_version_upgrade = var.redis_auto_minor_version_upgrade
  maintenance_window         = var.redis_maintenance_window
  snapshot_window            = var.redis_snapshot_window

  /* lifecycle {
    ignore_changes = [num_node_groups, replicas_per_node_group]
  } */

  log_delivery_configuration {
    destination       = aws_cloudwatch_log_group.log_group.name
    destination_type  = "cloudwatch-logs"
    log_format        = "text"
    log_type          = "slow-log"
  }

  timeouts {
    create = "60m"
    delete = "2h"
    update = "40m"
  }
}
