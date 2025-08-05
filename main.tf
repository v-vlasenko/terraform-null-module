/**
 * # terraform-null-module
 * !
 * Module `terraform-null-module` is a demonstration module,
 * consisting of a single `null_resource` resource.
 *
 * This module ultimately does nothing, but can be used to do an
 * end-to-end test of Terraform's registry functionality.
 * 
 * Usage Example:
 * 
 *     module "null_module" {
 *       source  = "vancluever/module/null"
 *       version = "2.0.2"
 *       trigger = "one"
 *     }
 * 
 */

# Primary AWS provider for us-east-1
provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      env = "environmentz"
      ScalrProvider = "environmentz-aws"
    }
  }
}

resource "aws_iam_policy" "safe_policy_east" {
  name        = "safe-policy-east"
  description = "A policy that passes all Checkov checks - East"
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Action    = ["s3:GetObject"]
      Resource  = ["arn:aws:s3:::example-bucket-east/specific-path/*"]
      Condition = {
        IpAddress = {"aws:SourceIp" = ["192.0.2.0/24"]}
      }
    }]
  })
}


# Outputs to verify tag merging
output "east_policy_tags" {
  value = aws_iam_policy.safe_policy_east.tags_all
}


variable "trigger" {
  description = "The trigger value for the `null_resource` resource in this module."
  default     = "one"
}

resource "null_resource" "resource" {
  triggers = {
    number = "${var.trigger}"
  }
}

resource "null_resource" "resource2" {
  count = 1000
  triggers = {
    number = "${var.trigger}"
  }
}


output "null_resource_id" {
  description = "The `id` of the `null_resource` resource in this module."
  value       = "${null_resource.resource.id}"
}

