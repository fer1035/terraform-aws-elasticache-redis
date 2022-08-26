resource "aws_appautoscaling_target" "replicas" {
  service_namespace  = "elasticache"
  scalable_dimension = "elasticache:replication-group:Replicas"
  resource_id        = "replication-group/${var.redis_id}-cluster"
  min_capacity       = var.redis_num_replicas
  max_capacity       = var.redis_max_replicas

  depends_on = [
    aws_elasticache_replication_group.redis_cluster_enabled
  ]
}

resource "aws_appautoscaling_policy" "replicas" {
  name               = "redis-auto-scaling"
  service_namespace  = aws_appautoscaling_target.replicas.service_namespace
  scalable_dimension = aws_appautoscaling_target.replicas.scalable_dimension
  resource_id        = aws_appautoscaling_target.replicas.resource_id
  policy_type        = "TargetTrackingScaling"

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = var.redis_metric_type
    }

    target_value       = var.redis_trigger_percent
    disable_scale_in   = var.redis_disable_scalein
    scale_in_cooldown  = var.redis_scalein_cooldown_seconds
    scale_out_cooldown = var.redis_scaleout_cooldown_seconds
  }
}

resource "aws_appautoscaling_target" "shards" {
  service_namespace  = "elasticache"
  scalable_dimension = "elasticache:replication-group:NodeGroups"
  resource_id        = "replication-group/${var.redis_id}-cluster"
  min_capacity       = var.redis_num_node_groups
  max_capacity       = var.redis_max_node_groups

  depends_on = [
    aws_elasticache_replication_group.redis_cluster_enabled
  ]
}

resource "aws_appautoscaling_policy" "shards" {
  name               = "redis-auto-scaling"
  service_namespace  = aws_appautoscaling_target.shards.service_namespace
  scalable_dimension = aws_appautoscaling_target.shards.scalable_dimension
  resource_id        = aws_appautoscaling_target.shards.resource_id
  policy_type        = "TargetTrackingScaling"

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = var.redis_metric_type
    }

    target_value       = var.redis_trigger_percent
    disable_scale_in   = var.redis_disable_scalein
    scale_in_cooldown  = var.redis_scalein_cooldown_seconds
    scale_out_cooldown = var.redis_scaleout_cooldown_seconds
  }
}

resource "aws_cloudwatch_metric_alarm" "alarm" {
  alarm_name          = var.log_group_name
  comparison_operator = var.redis_metric_operator
  evaluation_periods  = var.redis_evaluation_periods
  metric_name         = var.redis_metric_name
  namespace           = "AWS/ElastiCache"
  period              = var.redis_period_seconds
  statistic           = var.redis_metric_statistic
  threshold           = var.redis_metric_threshold
  actions_enabled     = var.redis_alarm_enabled
  datapoints_to_alarm = var.redis_metric_datapoints
  alarm_description   = var.description
  alarm_actions       = [aws_appautoscaling_policy.replicas.arn, aws_appautoscaling_policy.shards.arn]
  ok_actions          = [aws_appautoscaling_policy.replicas.arn, aws_appautoscaling_policy.shards.arn]
}
