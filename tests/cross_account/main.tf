# The provider account for the RAM share owner
provider "aws" {
  region  = "us-east-1"
  profile = "aws" # Profile must exist in your .aws/config
}

# AWS provider account for the RAM share member acccount
provider "aws" {
  region  = "us-east-1"
  alias   = "resource-member"
  profile = "awsalternate" # Profile must exist in your .aws/config
}

module "cross_account" {
  source = "../../modules/cross_account_principal_association"

  providers = {
    aws       = aws.resource-member
    aws.owner = aws
  }

  resource_share_arn = module.share.resource_share.arn
}

module "share" {
  source = "../.."

  name = "tardigrade-ram-${random_string.this.result}"

  allow_external_principals = true

  resources = [
    {
      name         = "resolver-rule"
      resource_arn = aws_route53_resolver_rule.this.arn
    }
  ]

  tags = {
    Environment = "testing"
  }
}

module "vpc" {
  source = "github.com/terraform-aws-modules/terraform-aws-vpc?ref=v5.15.0"

  name            = "tardigrade-ram-${random_string.this.result}"
  cidr            = "10.0.0.0/16"
  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
}

resource "aws_security_group" "this" {
  name        = "empty_sg"
  description = "empty_sg for testing"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_route53_resolver_endpoint" "this" {
  name      = "tardigrade-resolver-${random_string.this.result}"
  direction = "OUTBOUND"

  security_group_ids = [
    aws_security_group.this.id,
  ]

  ip_address {
    subnet_id = module.vpc.private_subnets[0]
    ip        = "10.0.1.4"
  }

  ip_address {
    subnet_id = module.vpc.private_subnets[1]
    ip        = "10.0.2.8"
  }
}

resource "aws_route53_resolver_rule" "this" {
  domain_name          = "${random_string.this.result}.com"
  name                 = "tardigrate-rr-${random_string.this.result}"
  rule_type            = "FORWARD"
  resolver_endpoint_id = aws_route53_resolver_endpoint.this.id

  target_ip {
    ip = "123.45.67.89"
  }
}

resource "random_string" "this" {
  length  = 6
  upper   = false
  special = false
  numeric = false
}

output "share" {
  value = module.share
}

output "cross_account" {
  value = module.cross_account
}
