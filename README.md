# AWS ElastiCache Redis Terraform Module

A Terraform module to provision AWS ElastiCache Redis, an unstructured in-memory caching database where data is stored as key-value pairs.

```bash
redis_endpoint:redis_port> SET x "hello"
OK
redis_endpoint:redis_port> KEYS *
1) "x"
redis_endpoint:redis_port> GET x
hello
```

---

## Features

Different AWS ElastiCache Redis implementation types:

![Image: AWS ElastiCache Redis types deployed by this module.](https://raw.githubusercontent.com/fer1035/terraform-aws-elasticache-redis/main/img/readme.png)

| Feature | Instance | Cluster-Disabled | Cluster-Enabled |
| :---: | :---: | :---: | :---: |
| Shard | No | Single | Single or Multiple |
| Multi-AZ | No | Possible | Possible |
| Auto-Failover | No | Possible | Yes |
| Scaling | Node scale-up | Primary node scale-up, Read-Replica scale-up and scale-out | Primary node scale-up, Read-Replica scale-up and scale-out, shard scale-out |
| Autoscaling | No | No | Possible |
| Partitioning | No | No | Possible (with multiple shards) |
| Connection | Node endpoint | Primary and Reader endpoints | Configuration endpoint (Primary and Reader configuration managed by cluster and transparent to user)
| Authentication | Possible | Possible | Possible |
| Encryption | Possible | Possible | Possible |

---

## Special Notes

### General

- A shard is a group of 1 Primary node and up to 5 Read-Replicas.
- Some scaling events may require destroying existing resources and recreating, which may cause data loss if no snapshot is available.
- ElastiCache is designed to be accessible only from within its AWS VPC. Public connections will require a VPN endpoint into the VPC.

### Defaults

The defaults for this module create:

- Redis engine for the latest 6.x version.
- Node type: cache.t4g.micro (2 vCPU, 1GB memory).
- A cluster-disabled Replication Group.
- A shard with 1 Primary node and 2 Read-Replicas.
- No Multi-AZ and automatic failover.
- An SNS notification Topic.
- A CloudWatch Log Group for Redis application.
- A CloudWatch Log Group for Redis engine.
- 2 users and a user group without authentication (no password by default).
- No encryption.
- No final snapshot.
- All resources in an AWS *default* VPC (will cause an error if there is none, and you will need to configure it with non-default-VPC inputs instead).

### Autoscaling

Current autoscaling [conditions](https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/AutoScaling.html):

- Redis (Cluster-Enabled) engine version 6.0.0 onwards.
- Instance type families - R5, R6g, M5, M6g.
- Instance sizes - Large, XLarge, 2XLarge.
- Autoscaling in ElastiCache Redis is not supported for clusters running in Global datastores, Outposts or Local Zones.
- Autoscaling for ElastiCache Redis is not available in the following regions: China (Beijing), China (Ningxia), AWS GovCloud (US-West) and AWS GovCloud (US-East).

### Service Quotas

Calculation examples for maximum autoscaling [limits](https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/Shards.html):

- Conditions:
    - Maximum of 5 Read-Replicas per shard.
    - Maximum of 500 nodes for Redis version 5.0.6 or later.
    - Maximum of 90 nodes for Redis versions prior to 5.0.6.
- If each shard has only 1 Primary node and no Read-Replica:
    - Redis 5.0.6 or later:
        - 500 / 1 = 500 shards
    - Redis prior to 5.0.6:
        - 90 / 1 = 90 shards
- If each shard has 1 Primary node and 3 Read-Replicas:
    - Redis 5.0.6 or later:
        - 500 / 4 = 125 shards
    - Redis prior to 5.0.6:
        - 90 / 4 = 22.5, therefore 22 shards
- If each shard has 1 Primary node and 5 Read-Replicas:
    - Redis 5.0.6 or later:
        - 500 / 6 = 83.333, therefore 83 shards
    - Redis prior to 5.0.6:
        - 90 / 6 = 15 shards

### Persistence

Persistence is not available in this module due to the following reasons:

- It is only available for Redis versions prior to 2.8.22.
- It is not available for Multi-AZ.
- AWS [outlines](https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/RedisAOF.html) several issues with using Append-Only-File (AOF) for persistence, and advises using Multi-AZ and automatic failover for better reliability and faster recovery.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_appautoscaling_policy.replicas](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_policy.shards](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_target.replicas](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target) | resource |
| [aws_appautoscaling_target.shards](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target) | resource |
| [aws_cloudwatch_log_group.engine_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_group.slow_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_elasticache_cluster.cluster_disabled](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_cluster) | resource |
| [aws_elasticache_cluster.cluster_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_cluster) | resource |
| [aws_elasticache_parameter_group.parameter_group_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_parameter_group) | resource |
| [aws_elasticache_parameter_group.parameter_group_nocluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_parameter_group) | resource |
| [aws_elasticache_replication_group.redis_cluster_disabled](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_replication_group) | resource |
| [aws_elasticache_replication_group.redis_cluster_enabled](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_replication_group) | resource |
| [aws_elasticache_subnet_group.subnet_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_subnet_group) | resource |
| [aws_elasticache_user.default_user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_user) | resource |
| [aws_elasticache_user.user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_user) | resource |
| [aws_elasticache_user_group.group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_user_group) | resource |
| [aws_elasticache_user_group_association.user_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_user_group_association) | resource |
| [aws_iam_role.iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_sns_topic.topic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_autoscaling_enabled"></a> [autoscaling\_enabled](#input\_autoscaling\_enabled) | Whether to create autoscaling for "cluster-enabled" cluster\_mode. Refer to autoscaling special notes in the README. | `bool` | `false` | no |
| <a name="input_cluster_mode"></a> [cluster\_mode](#input\_cluster\_mode) | Whether to deploy Redis as "instance", "cluster-disabled", or "cluster-enabled". | `string` | `"cluster-disabled"` | no |
| <a name="input_description"></a> [description](#input\_description) | Human-friendly description of the Redis application. | `string` | `"Redis application managed by Terraform."` | no |
| <a name="input_group_id"></a> [group\_id](#input\_group\_id) | ID of the Redis user group. | `string` | `"redisgroupid"` | no |
| <a name="input_log_group_retention"></a> [log\_group\_retention](#input\_log\_group\_retention) | Number of days to keep logs. 0 means indefinitely. | `number` | `0` | no |
| <a name="input_parameter_group_family"></a> [parameter\_group\_family](#input\_parameter\_group\_family) | Family name of the parameter group. | `string` | `"redis6.x"` | no |
| <a name="input_parameter_group_name"></a> [parameter\_group\_name](#input\_parameter\_group\_name) | Name of the parameter group. | `string` | `"cache-params"` | no |
| <a name="input_redis_alarm_enabled"></a> [redis\_alarm\_enabled](#input\_redis\_alarm\_enabled) | Whether to enable alarm actions for "cluster-enabled" autoscaling. | `bool` | `true` | no |
| <a name="input_redis_apply_immediately"></a> [redis\_apply\_immediately](#input\_redis\_apply\_immediately) | Whether to apply changes immediately or during next maintenance window. | `bool` | `true` | no |
| <a name="input_redis_at_rest_encryption"></a> [redis\_at\_rest\_encryption](#input\_redis\_at\_rest\_encryption) | Whether to enable encryption at rest for cache data. | `bool` | `false` | no |
| <a name="input_redis_auth_token"></a> [redis\_auth\_token](#input\_redis\_auth\_token) | Password to use with protected servers if transit\_encryption\_enabled is true. | `string` | `null` | no |
| <a name="input_redis_auto_failover"></a> [redis\_auto\_failover](#input\_redis\_auto\_failover) | Whether to enable automatic failover. Automatically enabled for "cluster-enabled" cluster\_mode, and if Multi-AZ is enabled. | `bool` | `false` | no |
| <a name="input_redis_auto_minor_version_upgrade"></a> [redis\_auto\_minor\_version\_upgrade](#input\_redis\_auto\_minor\_version\_upgrade) | Whether to automatically upgrade minor cache cluster version during next maintenance window. | `bool` | `true` | no |
| <a name="input_redis_cluster_azs"></a> [redis\_cluster\_azs](#input\_redis\_cluster\_azs) | List of preferred Availability Zones. The first value will be used for Primary node and AZ for "instance" cluster\_mode. | `list(string)` | `null` | no |
| <a name="input_redis_data_tiering"></a> [redis\_data\_tiering](#input\_redis\_data\_tiering) | Whether to enable data tiering. Only available and must be set for r6gd node types. | `bool` | `false` | no |
| <a name="input_redis_disable_scalein"></a> [redis\_disable\_scalein](#input\_redis\_disable\_scalein) | Whether to disable automatic scale-in for "cluster-enabled" autoscaling. | `bool` | `false` | no |
| <a name="input_redis_engine_type"></a> [redis\_engine\_type](#input\_redis\_engine\_type) | Cluster engine type. Only "redis" is supported. | `string` | `"redis"` | no |
| <a name="input_redis_engine_version"></a> [redis\_engine\_version](#input\_redis\_engine\_version) | Redis engine version. Unspecifying this gives the latest. | `string` | `null` | no |
| <a name="input_redis_evaluation_periods"></a> [redis\_evaluation\_periods](#input\_redis\_evaluation\_periods) | Metric evaluation period for "cluster-enabled" autoscaling. | `string` | `"3"` | no |
| <a name="input_redis_final_snapshot_name"></a> [redis\_final\_snapshot\_name](#input\_redis\_final\_snapshot\_name) | Name of the final snapshot for the Redis cache data. Must be unique and starts with a letter. Ignore if not creating final snapshot. | `string` | `null` | no |
| <a name="input_redis_id"></a> [redis\_id](#input\_redis\_id) | Redis application ID. | `string` | `"tf-redis"` | no |
| <a name="input_redis_kms_id"></a> [redis\_kms\_id](#input\_redis\_kms\_id) | KMS key ID for at rest encryption. | `string` | `null` | no |
| <a name="input_redis_maintenance_window"></a> [redis\_maintenance\_window](#input\_redis\_maintenance\_window) | Maintenance window. | `string` | `"tue:06:30-tue:07:30"` | no |
| <a name="input_redis_max_node_groups"></a> [redis\_max\_node\_groups](#input\_redis\_max\_node\_groups) | Maximum number of node groups for "cluster-enabled" autoscaling. Refer to service quotas special notes in the README. | `number` | `10` | no |
| <a name="input_redis_max_replicas"></a> [redis\_max\_replicas](#input\_redis\_max\_replicas) | Maximum number of replicas in a node group for "cluster-enabled" autoscaling. Refer to service quotas special notes in the README. | `number` | `5` | no |
| <a name="input_redis_metric_datapoints"></a> [redis\_metric\_datapoints](#input\_redis\_metric\_datapoints) | Number of datapoints to alarm for "cluster-enabled" autoscaling. | `string` | `"2"` | no |
| <a name="input_redis_metric_name_node_groups"></a> [redis\_metric\_name\_node\_groups](#input\_redis\_metric\_name\_node\_groups) | Node group metric naame for "cluster-enabled" autoscaling. | `string` | `"DatabaseMemoryUsageCountedForEvictPercentage"` | no |
| <a name="input_redis_metric_name_replicas"></a> [redis\_metric\_name\_replicas](#input\_redis\_metric\_name\_replicas) | Replica metric naame for "cluster-enabled" autoscaling. | `string` | `"ReplicaEngineCPUUtilization"` | no |
| <a name="input_redis_metric_operator"></a> [redis\_metric\_operator](#input\_redis\_metric\_operator) | Metric comparison operator for "cluster-enabled" autoscaling. | `string` | `"GreaterThanOrEqualToThreshold"` | no |
| <a name="input_redis_metric_statistic"></a> [redis\_metric\_statistic](#input\_redis\_metric\_statistic) | Metric statistic type for "cluster-enabled" autoscaling. | `string` | `"Minimum"` | no |
| <a name="input_redis_metric_threshold"></a> [redis\_metric\_threshold](#input\_redis\_metric\_threshold) | Metric statistic threshold for "cluster-enabled" autoscaling. | `string` | `"100"` | no |
| <a name="input_redis_metric_type_node_groups"></a> [redis\_metric\_type\_node\_groups](#input\_redis\_metric\_type\_node\_groups) | Node group metric type to monitor for "cluster-enabled" autoscaling. Valid value currently is "ElastiCacheReplicaEngineCPUUtilization". | `string` | `"ElastiCacheDatabaseMemoryUsageCountedForEvictPercentage"` | no |
| <a name="input_redis_metric_type_replicas"></a> [redis\_metric\_type\_replicas](#input\_redis\_metric\_type\_replicas) | Replica metric type to monitor for "cluster-enabled" autoscaling. Valid values are "ElastiCachePrimaryEngineCPUUtilization", "ElastiCacheReplicaEngineCPUUtilization", or "ElastiCacheDatabaseMemoryUsageCountedForEvictPercentage". | `string` | `"ElastiCacheReplicaEngineCPUUtilization"` | no |
| <a name="input_redis_multi_az"></a> [redis\_multi\_az](#input\_redis\_multi\_az) | Whether to enable multi-AZ. Enabling this will automatically enable automatic failover. | `bool` | `false` | no |
| <a name="input_redis_node_type"></a> [redis\_node\_type](#input\_redis\_node\_type) | Node type. | `string` | `"cache.t4g.micro"` | no |
| <a name="input_redis_num_cache_clusters"></a> [redis\_num\_cache\_clusters](#input\_redis\_num\_cache\_clusters) | Number of nodes for "cluster-disabled" cluster\_mode. Minimum should be 2 for Multi-AZ and automatic failover, where one is Primary and the other is Read-Replica. Refer to service quotas special notes in the README. | `number` | `2` | no |
| <a name="input_redis_num_node_groups"></a> [redis\_num\_node\_groups](#input\_redis\_num\_node\_groups) | Number of node groups for "cluster-enabled" cluster\_mode, also minimum count for "cluster-enabled" shard autoscaling. | `number` | `2` | no |
| <a name="input_redis_num_replicas"></a> [redis\_num\_replicas](#input\_redis\_num\_replicas) | Number of Read-Replicas for "cluster-enabled" cluster\_mode, and additional Read-Replicas for "cluster-disabled" cluster\_mode. Also minimum count for "cluster-enabled" replica autoscaling. Refer to service quotas special notes in the README. | `number` | `1` | no |
| <a name="input_redis_period_seconds"></a> [redis\_period\_seconds](#input\_redis\_period\_seconds) | Period duration in seconds for "cluster-enabled" autoscaling. | `string` | `"120"` | no |
| <a name="input_redis_port"></a> [redis\_port](#input\_redis\_port) | Redis connection port. | `number` | `6379` | no |
| <a name="input_redis_scalein_cooldown_seconds"></a> [redis\_scalein\_cooldown\_seconds](#input\_redis\_scalein\_cooldown\_seconds) | Autoscaling scale-in cooldown period in seconds for "cluster-enabled" autoscaling. | `number` | `300` | no |
| <a name="input_redis_scaleout_cooldown_seconds"></a> [redis\_scaleout\_cooldown\_seconds](#input\_redis\_scaleout\_cooldown\_seconds) | Autoscaling scale-out cooldown period in seconds for "cluster-enabled" autoscaling. | `number` | `300` | no |
| <a name="input_redis_sgids"></a> [redis\_sgids](#input\_redis\_sgids) | List of Security Groups to attach to the Redis application. | `list(string)` | `null` | no |
| <a name="input_redis_snapshot_retention_limit"></a> [redis\_snapshot\_retention\_limit](#input\_redis\_snapshot\_retention\_limit) | Number of days to keep the cache snapshot. 0 disables backup. | `number` | `30` | no |
| <a name="input_redis_snapshot_window"></a> [redis\_snapshot\_window](#input\_redis\_snapshot\_window) | Daily time range to take snapshots. | `string` | `"01:00-02:00"` | no |
| <a name="input_redis_subnet_ids"></a> [redis\_subnet\_ids](#input\_redis\_subnet\_ids) | List of Subnet IDs in which to create the Redis application. | `list(string)` | `null` | no |
| <a name="input_redis_transit_encryption"></a> [redis\_transit\_encryption](#input\_redis\_transit\_encryption) | Whether to enable encryption in transit for cache data. | `bool` | `false` | no |
| <a name="input_redis_trigger_percent_node_groups"></a> [redis\_trigger\_percent\_node\_groups](#input\_redis\_trigger\_percent\_node\_groups) | Node group database memory percentage amount to trigger for "cluster-enabled" autoscaling. | `number` | `75` | no |
| <a name="input_redis_trigger_percent_replicas"></a> [redis\_trigger\_percent\_replicas](#input\_redis\_trigger\_percent\_replicas) | Replica CPU utilization percentage amount to trigger for "cluster-enabled" autoscaling. | `number` | `65` | no |
| <a name="input_user_access_string"></a> [user\_access\_string](#input\_user\_access\_string) | Access string for the Redis user. | `string` | `"on ~app::* -@all +@read +@hash +@bitmap +@geo -setbit -bitfield -hset -hsetnx -hmset -hincrby -hincrbyfloat -hdel -bitop -geoadd -georadius -georadiusbymember"` | no |
| <a name="input_user_id"></a> [user\_id](#input\_user\_id) | ID of the Redis user. | `string` | `"redisuserid"` | no |
| <a name="input_user_name"></a> [user\_name](#input\_user\_name) | Name of the Redis user. | `string` | `"redisUser"` | no |
| <a name="input_user_no_password"></a> [user\_no\_password](#input\_user\_no\_password) | Whether to allow no password for the user. Must be false if user\_passwords is set. | `bool` | `true` | no |
| <a name="input_user_passwords"></a> [user\_passwords](#input\_user\_passwords) | Redis user password. | `list(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_disabled_cache_nodes"></a> [cluster\_disabled\_cache\_nodes](#output\_cluster\_disabled\_cache\_nodes) | Cache nodes of the "cluster-disabled" cluster\_mode. |
| <a name="output_cluster_disabled_redis_arn"></a> [cluster\_disabled\_redis\_arn](#output\_cluster\_disabled\_redis\_arn) | ARN of the "cluster-disabled" replication group. |
| <a name="output_cluster_disabled_redis_cluster_enabled"></a> [cluster\_disabled\_redis\_cluster\_enabled](#output\_cluster\_disabled\_redis\_cluster\_enabled) | Cluster status of the "cluster-disabled" replication group. |
| <a name="output_cluster_disabled_redis_engine_version"></a> [cluster\_disabled\_redis\_engine\_version](#output\_cluster\_disabled\_redis\_engine\_version) | Actual engine version of the "cluster-disabled" replication group. |
| <a name="output_cluster_disabled_redis_id"></a> [cluster\_disabled\_redis\_id](#output\_cluster\_disabled\_redis\_id) | ID of the "cluster-disabled" replication group. |
| <a name="output_cluster_disabled_redis_member_clusters"></a> [cluster\_disabled\_redis\_member\_clusters](#output\_cluster\_disabled\_redis\_member\_clusters) | Member clusters of the "cluster-disabled" replication group. |
| <a name="output_cluster_disabled_redis_primary_endpoint"></a> [cluster\_disabled\_redis\_primary\_endpoint](#output\_cluster\_disabled\_redis\_primary\_endpoint) | Primary endpoint address of the "cluster-disabled" replication group. |
| <a name="output_cluster_disabled_redis_reader_endpoint"></a> [cluster\_disabled\_redis\_reader\_endpoint](#output\_cluster\_disabled\_redis\_reader\_endpoint) | Reader endpoint address of the "cluster-disabled" replication group. |
| <a name="output_cluster_enabled_redis_arn"></a> [cluster\_enabled\_redis\_arn](#output\_cluster\_enabled\_redis\_arn) | ARN of the "cluster-enabled" replication group. |
| <a name="output_cluster_enabled_redis_cluster_enabled"></a> [cluster\_enabled\_redis\_cluster\_enabled](#output\_cluster\_enabled\_redis\_cluster\_enabled) | Cluster status of the "cluster-enabled" replication group. |
| <a name="output_cluster_enabled_redis_config_endpoint"></a> [cluster\_enabled\_redis\_config\_endpoint](#output\_cluster\_enabled\_redis\_config\_endpoint) | Configuration endpoint address of the "cluster-enabled" replication group. |
| <a name="output_cluster_enabled_redis_engine_version"></a> [cluster\_enabled\_redis\_engine\_version](#output\_cluster\_enabled\_redis\_engine\_version) | Actual engine version of the "cluster-enabled" replication group. |
| <a name="output_cluster_enabled_redis_id"></a> [cluster\_enabled\_redis\_id](#output\_cluster\_enabled\_redis\_id) | ID of the "cluster-enabled" replication group. |
| <a name="output_cluster_enabled_redis_member_clusters"></a> [cluster\_enabled\_redis\_member\_clusters](#output\_cluster\_enabled\_redis\_member\_clusters) | Member clusters of the "cluster-enabled" replication group. |
| <a name="output_engine_logs"></a> [engine\_logs](#output\_engine\_logs) | CloudWatch Logs group for the Redis engine. |
| <a name="output_instance_actual_engine_version"></a> [instance\_actual\_engine\_version](#output\_instance\_actual\_engine\_version) | Actual engine version of the "instance" cluster\_mode. |
| <a name="output_instance_arn"></a> [instance\_arn](#output\_instance\_arn) | ARN of the "instance" cluster\_mode. |
| <a name="output_instance_cache_nodes"></a> [instance\_cache\_nodes](#output\_instance\_cache\_nodes) | Cache nodes of the "instance" cluster\_mode. |
| <a name="output_redis_port"></a> [redis\_port](#output\_redis\_port) | Redis connection port. |
| <a name="output_slow_logs"></a> [slow\_logs](#output\_slow\_logs) | CloudWatch Logs group for the Redis application. |
| <a name="output_sns_topic"></a> [sns\_topic](#output\_sns\_topic) | SNS notification topic for the Redis application. |
