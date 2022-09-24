variable "description" {
  type        = string
  description = "Human-friendly description of the Redis application."
  default     = "Redis application managed by Terraform."
}

variable "cluster_mode" {
  type        = string
  description = "Whether to deploy Redis as \"instance\", \"cluster-disabled\", or \"cluster-enabled\"."
  default     = "cluster-disabled"
}

variable "autoscaling_enabled" {
  type        = bool
  description = "Whether to create autoscaling for \"cluster-enabled\" cluster_mode. Refer to autoscaling special notes in the README."
  default     = false
}

variable "redis_id" {
  type        = string
  description = "Redis application ID."
  default     = "tf-redis"
}

variable "redis_node_type" {
  type        = string
  description = "Node type."
  default     = "cache.t4g.micro"
}

variable "redis_port" {
  type        = number
  description = "Redis connection port."
  default     = 6379
}

variable "redis_multi_az" {
  type        = bool
  description = "Whether to enable multi-AZ. Enabling this also enables automatic failover."
  default     = false
}

variable "redis_cluster_azs" {
  type        = list(string)
  description = "List of preferred Availability Zones. The first value will be used for Primary node and AZ for \"instance\" cluster_mode."
  default     = null  # ["us-east-1a"]
}

variable "redis_num_cache_clusters" {
  type        = number
  description = "Number of cache clusters for \"cluster-disabled\" cluster_mode. Minimum should be 2 for Multi-AZ and automatic failover."
  default     = 2
}

variable "redis_num_node_groups" {
  type        = number
  description = "Number of node groups for \"cluster-enabled\" cluster_mode, also minimum count for \"cluster-enabled\" shard autoscaling."
  default     = 2
}

variable "redis_num_replicas" {
  type        = number
  description = "Number of read-replicas for \"cluster-disabled\" and \"cluster-enabled\" cluster_mode, also minimum count for \"cluster-enabled\" replica autoscaling."
  default     = 1
}

variable "redis_max_node_groups" {
  type        = number
  description = "Maximum number of node groups for \"cluster-enabled\" autoscaling. Refer to service quotas special notes in the README."
  default     = 10
}

variable "redis_max_replicas" {
  type        = number
  description = "Maximum number of replicas in a node group for \"cluster-enabled\" autoscaling. Refer to service quotas special notes in the README."
  default     = 5
}

variable "redis_trigger_percent_replicas" {
  type        = number
  description = "Replica CPU utilization percentage amount to trigger for \"cluster-enabled\" autoscaling."
  default     = 65
}

variable "redis_trigger_percent_node_groups" {
  type        = number
  description = "Node group database memory percentage amount to trigger for \"cluster-enabled\" autoscaling."
  default     = 75
}

variable "redis_scalein_cooldown_seconds" {
  type        = number
  description = "Autoscaling scale-in cooldown period in seconds for \"cluster-enabled\" autoscaling."
  default     = 300
}

variable "redis_scaleout_cooldown_seconds" {
  type        = number
  description = "Autoscaling scale-out cooldown period in seconds for \"cluster-enabled\" autoscaling."
  default     = 300
}

variable "redis_disable_scalein" {
  type        = bool
  description = "Whether to disable automatic scale-in for \"cluster-enabled\" autoscaling."
  default     = false
}

variable "redis_metric_operator" {
  type        = string
  description = "Metric comparison operator for \"cluster-enabled\" autoscaling."
  default     = "GreaterThanOrEqualToThreshold"
}

variable "redis_evaluation_periods" {
  type        = string
  description = "Metric evaluation period for \"cluster-enabled\" autoscaling."
  default     = "3"
}

variable "redis_period_seconds" {
  type        = string
  description = "Period duration in seconds for \"cluster-enabled\" autoscaling."
  default     = "120"
}

variable "redis_metric_statistic" {
  type        = string
  description = "Metric statistic type for \"cluster-enabled\" autoscaling."
  default     = "Minimum"
}

variable "redis_metric_threshold" {
  type        = string
  description = "Metric statistic threshold for \"cluster-enabled\" autoscaling."
  default     = "100"
}

variable "redis_metric_name_replicas" {
  type        = string
  description = "Replica metric naame for \"cluster-enabled\" autoscaling."
  default     = "ReplicaEngineCPUUtilization"
}

variable "redis_metric_name_node_groups" {
  type        = string
  description = "Node group metric naame for \"cluster-enabled\" autoscaling."
  default     = "DatabaseMemoryUsageCountedForEvictPercentage"
}

variable "redis_metric_datapoints" {
  type        = string
  description = "Number of datapoints to alarm for \"cluster-enabled\" autoscaling."
  default     = "2"
}

variable "redis_metric_type_replicas" {
  type        = string
  description = "Replica metric type to monitor for \"cluster-enabled\" autoscaling. Valid values are \"ElastiCachePrimaryEngineCPUUtilization\", \"ElastiCacheReplicaEngineCPUUtilization\", or \"ElastiCacheDatabaseMemoryUsageCountedForEvictPercentage\"."
  default     = "ElastiCacheReplicaEngineCPUUtilization"
}

variable "redis_metric_type_node_groups" {
  type        = string
  description = "Node group metric type to monitor for \"cluster-enabled\" autoscaling. Valid value currently is \"ElastiCacheReplicaEngineCPUUtilization\"."
  default     = "ElastiCacheDatabaseMemoryUsageCountedForEvictPercentage"
}

variable "redis_alarm_enabled" {
  type        = bool
  description = "Whether to enable alarm actions for \"cluster-enabled\" autoscaling."
  default     = true
}

variable "redis_apply_immediately" {
  type        = bool
  description = "Whether to apply changes immediately or during next maintenance window."
  default     = true
}

variable "redis_auto_minor_version_upgrade" {
  type        = bool
  description = "Whether to automatically upgrade minor cache cluster version during next maintenance window."
  default     = true
}

variable "redis_maintenance_window" {
  type        = string
  description = "Maintenance window."
  default     = "tue:06:30-tue:07:30"
}

variable "redis_snapshot_window" {
  type        = string
  description = "Daily time range to take snapshots."
  default     = "01:00-02:00"
}

variable "redis_sgids" {
  type        = list(string)
  description = "List of Security Groups to attach to the Redis application."
  default     = null
}

variable "redis_subnet_ids" {
  type        = list(string)
  description = "List of Subnet IDs in which to create the Redis application."
  default     = null
}

variable "redis_at_rest_encryption" {
  type        = bool
  description = "Whether to enable encryption at rest for cache data."
  default     = false
}

variable "redis_kms_id" {
  type        = string
  description = "KMS key ID for at rest encryption."
  default     = null
}

variable "redis_transit_encryption" {
  type        = bool
  description = "Whether to enable encryption in transit for cache data."
  default     = false
}

variable "redis_auth_token" {
  type        = string
  description = "Password to use with protected servers if transit_encryption_enabled is true."
  default     = null
}

variable "redis_data_tiering" {
  type        = bool
  description = "Whether to enable data tiering. Only available and must be set for r6gd node types."
  default     = false
}

variable "redis_engine_type" {
  type        = string
  description = "Cluster engine type. Only \"redis\" is supported."
  default     = "redis"
}

variable "redis_engine_version" {
  type        = string
  description = "Redis engine version. Unspecifying this gives the latest."
  default     = null
}

variable "redis_snapshot_retention_limit" {
  type        = number
  description = "Number of days to keep the cache snapshot. 0 disables backup."
  default     = 30
}

variable "redis_final_snapshot_name" {
  type        = string
  description = "Name of the final snapshot for the Redis cache data. Must be unique and starts with a letter. Ignore if not creating final snapshot."
  default     = null
}

variable "parameter_group_name" {
  type        = string
  description = "Name of the parameter group."
  default     = "cache-params"
}

variable "parameter_group_family" {
  type        = string
  description = "Family name of the parameter group."
  default     = "redis6.x"
}

variable "log_group_retention" {
  type        = number
  description = "Number of days to keep logs. 0 means indefinitely."
  default     = 0
}

variable "user_id" {
  type        = string
  description = "ID of the Redis user."
  default     = "redisuserid"
}

variable "user_name" {
  type        = string
  description = "Name of the Redis user."
  default     = "redisUser"
}

variable "user_access_string" {
  type        = string
  description = "Access string for the Redis user."
  default     = "on ~app::* -@all +@read +@hash +@bitmap +@geo -setbit -bitfield -hset -hsetnx -hmset -hincrby -hincrbyfloat -hdel -bitop -geoadd -georadius -georadiusbymember"
}

variable "user_passwords" {
  type        = list(string)
  description = "Redis user password."
  default     = null
}

variable "user_no_password" {
  type        = bool
  description = "Whether to allow no password for the user. Must be false if user_passwords is set."
  default     = true
}

variable "group_id" {
  type        = string
  description = "ID of the Redis user group."
  default     = "redisgroupid"
}
