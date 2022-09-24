resource "aws_elasticache_parameter_group" "parameter_group_nocluster" {
  count = var.cluster_mode != "cluster-enabled" ? 1 : 0

  name   = "${var.parameter_group_name}-nocluster"
  family = var.parameter_group_family

  parameter {
    name  = "activerehashing"
    value = "yes"
  }

  /* # This is only good for Single-AZ in Redis versions prior to 2.8.22.
    parameter {
    name  = "appendonly"
    value = "yes"
  } */
}

resource "aws_elasticache_parameter_group" "parameter_group_cluster" {
  count = var.cluster_mode == "cluster-enabled" ? 1 : 0

  name   = "${var.parameter_group_name}-cluster"
  family = var.parameter_group_family

  parameter {
    name  = "activerehashing"
    value = "yes"
  }

  parameter {
    name  = "cluster-enabled"
    value = "yes"
  }
}
