resource "aws_appautoscaling_target" "replicas" {
  count = var.autoscaling_enabled == true ? 1 : 0

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
  count = var.autoscaling_enabled == true ? 1 : 0

  name               = "redis-auto-scaling"
  service_namespace  = aws_appautoscaling_target.replicas[0].service_namespace
  scalable_dimension = aws_appautoscaling_target.replicas[0].scalable_dimension
  resource_id        = aws_appautoscaling_target.replicas[0].resource_id
  policy_type        = "TargetTrackingScaling"

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = var.redis_metric_type_replicas
    }

    target_value       = var.redis_trigger_percent
    disable_scale_in   = var.redis_disable_scalein
    scale_in_cooldown  = var.redis_scalein_cooldown_seconds
    scale_out_cooldown = var.redis_scaleout_cooldown_seconds
  }
}

resource "aws_appautoscaling_target" "shards" {
  count = var.autoscaling_enabled == true ? 1 : 0

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
  count = var.autoscaling_enabled == true ? 1 : 0

  name               = "redis-auto-scaling"
  service_namespace  = aws_appautoscaling_target.shards[0].service_namespace
  scalable_dimension = aws_appautoscaling_target.shards[0].scalable_dimension
  resource_id        = aws_appautoscaling_target.shards[0].resource_id
  policy_type        = "TargetTrackingScaling"

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = var.redis_metric_type_node_groups
    }

    target_value       = var.redis_trigger_percent
    disable_scale_in   = var.redis_disable_scalein
    scale_in_cooldown  = var.redis_scalein_cooldown_seconds
    scale_out_cooldown = var.redis_scaleout_cooldown_seconds
  }
}

resource "aws_cloudwatch_metric_alarm_replicas" "alarm_replicas" {
  count = var.autoscaling_enabled == true ? 1 : 0

  alarm_name          = var.log_group_name
  comparison_operator = var.redis_metric_operator
  evaluation_periods  = var.redis_evaluation_periods
  metric_name         = var.redis_metric_name_replicas
  namespace           = "AWS/ElastiCache"
  period              = var.redis_period_seconds
  statistic           = var.redis_metric_statistic
  threshold           = var.redis_metric_threshold
  actions_enabled     = var.redis_alarm_enabled
  datapoints_to_alarm = var.redis_metric_datapoints
  alarm_description   = var.description
  alarm_actions       = [aws_appautoscaling_policy.replicas[0].arn, aws_appautoscaling_policy.shards[0].arn]
  ok_actions          = [aws_appautoscaling_policy.replicas[0].arn, aws_appautoscaling_policy.shards[0].arn]
}

resource "aws_cloudwatch_metric_alarm_node_groups" "alarm_node_groups" {
  count = var.autoscaling_enabled == true ? 1 : 0

  alarm_name          = var.log_group_name
  comparison_operator = var.redis_metric_operator
  evaluation_periods  = var.redis_evaluation_periods
  metric_name         = var.redis_metric_name_node_groups
  namespace           = "AWS/ElastiCache"
  period              = var.redis_period_seconds
  statistic           = var.redis_metric_statistic
  threshold           = var.redis_metric_threshold
  actions_enabled     = var.redis_alarm_enabled
  datapoints_to_alarm = var.redis_metric_datapoints
  alarm_description   = var.description
  alarm_actions       = [aws_appautoscaling_policy.replicas[0].arn, aws_appautoscaling_policy.shards[0].arn]
  ok_actions          = [aws_appautoscaling_policy.replicas[0].arn, aws_appautoscaling_policy.shards[0].arn]
}
