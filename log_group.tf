resource "aws_cloudwatch_log_group" "log_group" {
  name              = "${var.redis_id}-logs"
  retention_in_days = var.log_group_retention
  kms_key_id        = var.redis_kms_id
}
