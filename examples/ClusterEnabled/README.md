# AWS Elasticache Redis Terraform Module

Example for: Cluster-Enabled

| Feature | Cluster-Enabled |
| :---: | :---: |
| Shard | Single or Multiple |
| Multi-AZ | Possible |
| Auto-Failover | Yes |
| Scaling | Primary node scale-up, Read-Replica scale-up and scale-out, shard scale-out |
| Autoscaling | Possible |
| Partitioning | Possible (with multiple shards) |
| Connection | Configuration endpoint (Primary and Reader configuration managed by cluster and transparent to user)
| Authentication | Possible |
| Encryption | Possible |

## Prerequisites

1. You will need to define a *region* and (optionally) some *default tags* using the *provider* block:

    ```hcl
    provider "aws" {
      region = "us-east-1"

      default_tags {
        tags = {
          Name = "Redis-Cluster-Enabled"
        }
      }
    }
    ```

2. The example creates its own VPC and Security Group for the Redis cluster.
