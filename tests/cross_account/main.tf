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

  tags = {
    Environment = "testing"
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
