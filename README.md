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
