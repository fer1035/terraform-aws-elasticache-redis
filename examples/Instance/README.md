# AWS Elasticache Redis Terraform Module

Example for: Instance

| Feature | Instance |
| :---: | :---: |
| Shard | No |
| Multi-AZ | No |
| Auto-Failover | No |
| Scaling | Node scale-up |
| Autoscaling | No |
| Partitioning | No |
| Connection | Node endpoint |
| Authentication | Possible |
| Encryption | Possible |

## Prerequisites

1. You will need to define a *region* and (optionally) some *default tags* using the *provider* block:

    ```hcl
    provider "aws" {
      region = "us-east-1"

      default_tags {
        tags = {
          Name = "Redis-Instance"
        }
      }
    }
    ```

2. The example creates its own VPC and Security Group for the Redis cluster.
