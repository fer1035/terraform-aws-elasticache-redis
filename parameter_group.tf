resource "aws_elasticache_parameter_group" "parameter_group_nocluster" {
  count = var.cluster_mode != "cluster-enabled" ? 1 : 0

  name   = var.parameter_group_name
  family = var.parameter_group_family

  parameter {
    name  = "activerehashing"
    value = "yes"
  }

  /* parameter {
    name  = "min-slaves-to-write"
    value = "2"
  } */
}

resource "aws_elasticache_parameter_group" "parameter_group_cluster" {
  count = var.cluster_mode == "cluster-enabled" ? 1 : 0

  name   = var.parameter_group_name
  family = var.parameter_group_family

  parameter {
    name  = "activerehashing"
    value = "yes"
  }

  /* parameter {
    name  = "min-slaves-to-write"
    value = "2"
  } */

  parameter {
    name  = "cluster-enabled"
    value = true
  }
}
