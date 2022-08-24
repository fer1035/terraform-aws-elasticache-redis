resource "aws_iam_role" "iam_role" {
  name = "redis_${var.redis_id}_role"
  /* managed_policy_arns = null */
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "elasticache.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": "ElasticacheAssumeRole"
    }
  ]
}
EOF
  inline_policy {
    name = "redis_${var.redis_id}_policy"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Effect   = "Allow"
          Action   = "logs:*"
          Resource = aws_cloudwatch_log_group.log_group.arn
        },
        {
          Effect   = "Allow"
          Action   = "sns:Publish"
          Resource = aws_sns_topic.topic.arn
        }
      ]
    })
  }
}
