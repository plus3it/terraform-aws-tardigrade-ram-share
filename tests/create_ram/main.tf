provider aws {
  region  = "us-east-1"
  profile = "resource-member"
}

provider aws {
  region  = "us-east-1"
  alias   = "resource-owner"
  profile = "resource-owner"
}

data "aws_caller_identity" "current" {
  provider = aws
}

data "terraform_remote_state" "prereq" {
  backend = "local"
  config = {
    path = "prereq/terraform.tfstate"
  }
}

module "create_ram_accept" {
  source = "../../"
  providers = {
    aws       = aws
    aws.owner = aws.resource-owner
  }

  create_ram_principal_association = true

  auto_accept        = true
  principal          = data.aws_caller_identity.current.account_id
  resource_share_arn = data.terraform_remote_state.prereq.outputs.ram_arn
}

output "create_ram_accept" {
  value = module.create_ram_accept
}
