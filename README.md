# AWS Elasticache Redis Terraform Module

A Terraform module to provision AWS ElastiCache Redis application.

## Features

- Allows provisioning of different Redis application types:
    - Single instance
    - Replication group (cluster-disabled)
    - Cluster-enabled

## Special Notes for Autoscaling

Current autoscaling [conditions](https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/AutoScaling.html):

- Redis (cluster mode enabled) clusters running Redis engine version 6.0 onwards.
- Instance type families - R5, R6g, M5, M6g.
- Instance sizes - Large, XLarge, 2XLarge.
- Auto Scaling in ElastiCache for Redis is not supported for clusters running in Global datastores, Outposts or Local Zones.
- AWS Auto Scaling for ElastiCache for Redis is not available in the following regions: China (Beijing), China (Ningxia), AWS GovCloud (US-West) and AWS GovCloud (US-East).
