resource "aws_sns_topic" "topic" {
  name = "${var.redis_id}-sns-topic"
}