# AWS Elasticache Redis Terraform Module

Example for: Cluster-Disabled Replication Group

| Feature | Cluster-Disabled |
| :---: | :---: |
| Shard | Single |
| Multi-AZ | Possible |
| Auto-Failover | Possible |
| Scaling | Primary node scale-up, Read-Replica scale-up and scale-out |
| Autoscaling | No |
| Partitioning | No |
| Connection | Primary and Reader endpoints |
| Authentication | Possible |
| Encryption | Possible |

## Prerequisites

1. You will need to define a *region* and (optionally) some *default tags* using the *provider* block:

    ```hcl
    provider "aws" {
      region = "us-east-1"

      default_tags {
        tags = {
          Name = "Redis-Cluster-Disabled"
        }
      }
    }
    ```

2. The example creates its own VPC and Security Group for the Redis cluster.
