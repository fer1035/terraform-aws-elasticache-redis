variable "description" {
  type        = string
  description = "Human-friendly description of the Redis application."
  default     = "Redis application managed by Terraform."
}

variable "cluster_mode" {
  type        = string
  description = "Whether to deploy Redis as \"instance\", \"cluster-disabled\", or \"cluster-enabled\"."
  default     = "instance"
}

variable "replication_group_id" {
  type        = string
  description = "Redis cluster replication group ID."
  default     = "tf-redis-cluster-rep-grp"
}

variable "replication_group_node_type" {
  type        = string
  description = "Node type of the replication group."
  default     = "cache.t2.small"
}

variable "replication_group_port" {
  type        = number
  description = "Port of the replication group."
  default     = 6379
}

variable "replication_group_failover" {
  type        = bool
  description = "Whether to enable replication group failover with multi-AZ. Ignored if using \"instance\" cluster_mode."
  default     = true
}

variable "replication_group_multi_az" {
  type        = bool
  description = "Whether to enable replication group multi-AZ. Must correspond with replication_group_failover."
  default     = true
}

variable "replication_group_cluster_azs" {
  type        = list(string)
  description = "List of preferred cache cluster Availability Zones. The first value will be used for Primary node and AZ for \"instance\" cluster_mode."
  default     = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1e", "us-east-1f"]
}

variable "replication_group_num_node_groups" {
  type        = number
  description = "Number of node groups for the replication group. Only for \"cluster-enabled\" cluster_mode."
  default     = 2
}

variable "replication_group_num_cache_clusters" {
  type        = number
  description = "Number of cache clusters for the replication group. Only for \"cluster-disabled\" cluster_mode."
  default     = 2
}

variable "replication_group_num_replicas" {
  type        = number
  description = "Number of replicas in each node group for the replication group. Ignored if using \"instance\" cluster_mode."
  default     = 1
}

variable "replication_group_apply_immediately" {
  type        = bool
  description = "Whether to apply changes immediately or during next maintenance window."
  default     = false
}

variable "replication_group_auto_minor_version_upgrade" {
  type        = bool
  description = "Whether to automatically upgrade minor cache cluster version during next maintenance window."
  default     = true
}

variable "replication_group_maintenance_window" {
  type        = string
  description = "Maintenance window for the replication group cache cluster."
  default     = "tue:06:30-tue:07:30"
}

variable "replication_group_snapshot_window" {
  type        = string
  description = "Daily time range to take snapshots."
  default     = "01:00-02:00"
}

variable "replication_group_sgids" {
  type        = list(string)
  description = "List of Security Groups to attach to the Redis application."
  default     = null
}

variable "replication_group_subnet_ids" {
  type        = list(string)
  description = "List of Subnet IDs in which to create the Redis application."
}

variable "replication_group_at_rest_encryption" {
  type        = bool
  description = "whether to enable encryption at rest for cache data."
  default     = false
}

variable "replication_group_kms_id" {
  type        = string
  description = "KMS key ID for at rest encryption."
  default     = null
}

variable "replication_group_transit_encryption" {
  type        = bool
  description = "Whether to enable encryption in transit for cache data."
  default     = false
}

variable "replication_group_auth_token" {
  type        = string
  description = "Password to use with protected servers if transit_encryption_enabled is true."
  default     = null
}

variable "replication_group_data_tiering" {
  type        = bool
  description = "Whether to enable data tiering. Only available and must be set for r6gd node types."
  default     = false
}

variable "replication_group_engine_type" {
  type        = string
  description = "Cluster engine type. Onlu \"redis\" is supported."
  default     = "redis"
}

variable "replication_group_engine_version" {
  type        = string
  description = "Cluster engine version. Unspecifying this gives the latest."
  default     = null
}

variable "replication_group_snapshot_retention_limit" {
  type        = number
  description = "Number of days to keep the cache snapshot. 0 disables backup."
  default     = 30
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

variable "log_group_name" {
  type        = string
  description = "Name of the log group."
  default     = "redis"
}

variable "log_group_retention" {
  type        = number
  description = "Number of days to keep logs. 0 means indefinitely."
  default     = 0
}

variable "sns_topic_name" {
  type        = string
  description = "Name of the SNS topic to deliver notifications."
  default     = null
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
