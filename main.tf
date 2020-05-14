provider "aws" {
}

provider "aws" {
  alias = "owner"
}

resource "aws_ram_principal_association" "this" {
  count = var.create_ram_principal_association ? 1 : 0

  provider = aws.owner

  principal          = var.principal
  resource_share_arn = var.resource_share_arn

  # The invitation sometime takes a few seconds to propagate
  provisioner "local-exec" {
    command = "python -c 'import time; time.sleep(5)'"
  }
}

resource "aws_ram_resource_share_accepter" "this" {
  count = local.create_ram_resource_share_accepter && var.auto_accept ? 1 : 0

  provider = aws

  share_arn = aws_ram_principal_association.this[0].resource_share_arn
}

data "aws_caller_identity" "this" {
  count = var.create_ram_principal_association ? 1 : 0
}

data "aws_caller_identity" "owner" {
  count    = var.create_ram_principal_association ? 1 : 0
  provider = aws.owner
}

locals {
  create_ram_resource_share_accepter = var.create_ram_principal_association ? data.aws_caller_identity.this[0].account_id != data.aws_caller_identity.owner[0].account_id : false
}
