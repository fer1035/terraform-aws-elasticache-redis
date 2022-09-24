# AWS Elasticache Redis Terraform Module

A Terraform module to provision AWS ElastiCache Redis application.

## Features

- Allows provisioning of different Redis application types:
    - Single instance
    - Replication group (cluster-disabled)
    - Cluster-enabled

## Special Notes

### Autoscaling

Current autoscaling [conditions](https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/AutoScaling.html):

- Redis (cluster mode enabled) clusters running Redis engine version 6.0 onwards.
- Instance type families - R5, R6g, M5, M6g.
- Instance sizes - Large, XLarge, 2XLarge.
- Auto Scaling in ElastiCache for Redis is not supported for clusters running in Global datastores, Outposts or Local Zones.
- AWS Auto Scaling for ElastiCache for Redis is not available in the following regions: China (Beijing), China (Ningxia), AWS GovCloud (US-West) and AWS GovCloud (US-East).

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
