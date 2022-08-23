resource "aws_elasticache_user" "user" {
  user_id       = var.user_id
  user_name     = var.user_name
  access_string = var.user_access_string
  engine        = upper(var.replication_group_engine_type)
  passwords     = var.user_passwords
}

resource "aws_elasticache_user_group" "group" {
  engine        = upper(var.replication_group_engine_type)
  user_group_id = var.group_id
  user_ids      = [aws_elasticache_user.user.user_id]

  /* lifecycle {
    ignore_changes = [user_ids]
  } */
}

resource "aws_elasticache_user_group_association" "user_group" {
  user_group_id = aws_elasticache_user_group.group.group_id
  user_id       = aws_elasticache_user.user.user_id
}
