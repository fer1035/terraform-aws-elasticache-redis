resource "aws_cloudwatch_log_group" "slow_logs" {
  name              = "${var.redis_id}-slow-logs"
  retention_in_days = var.log_group_retention
  kms_key_id        = var.redis_kms_id
}

resource "aws_cloudwatch_log_group" "engine_logs" {
  name              = "${var.redis_id}-engine-logs"
  retention_in_days = var.log_group_retention
  kms_key_id        = var.redis_kms_id
}
