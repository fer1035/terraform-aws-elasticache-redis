resource "aws_cloudwatch_log_group" "log_group" {
  name              = var.log_group_name
  retention_in_days = var.log_group_retention
  kms_key_id        = var.redis_kms_id
}
