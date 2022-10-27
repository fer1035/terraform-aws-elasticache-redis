resource "aws_elasticache_user" "default_user" {
  user_id              = var.default_user_id
  user_name            = "default"
  access_string        = var.user_access_string
  engine               = "REDIS"
  passwords            = var.user_passwords
  no_password_required = var.user_no_password
}

resource "aws_elasticache_user" "user" {
  user_id              = var.user_id
  user_name            = var.user_name
  access_string        = var.user_access_string
  engine               = "REDIS"
  passwords            = var.user_passwords
  no_password_required = var.user_no_password
}

resource "aws_elasticache_user_group" "group" {
  engine        = "REDIS"
  user_group_id = var.group_id
  user_ids      = [aws_elasticache_user.default_user.user_id]

  lifecycle {
    ignore_changes = [user_ids]
  }
}

resource "aws_elasticache_user_group_association" "user_group" {
  user_group_id = aws_elasticache_user_group.group.user_group_id
  user_id       = aws_elasticache_user.user.user_id
}
