provider "aws" {}

provider "aws" {
  alias = "owner"
}

resource "aws_ram_principal_association" "this" {
  count = "${var.create_ram_principal_association ? 1 : 0}"

  provider = "aws.owner"

  principal          = "${var.principal}"
  resource_share_arn = "${var.resource_share_arn}"
}

resource "null_resource" "this" {
  count = "${var.create_ram_principal_association && var.cross_account && var.auto_accept ? 1 : 0}"

  # The invite for the principal association sometimes takes a few seconds to register
  # before it can be accepted in the target account, so we pause for 3 seconds to let
  # the invite propagate
  provisioner "local-exec" {
    command = "python -c 'import time; time.sleep(3)'"
  }

  provisioner "local-exec" {
    command = "${join(" ", local.command)}"
  }
}

locals {
  # Replace a terraform-aws-provider sts assumed role with the equivalent iam role, i.e:
  #     arn:aws:sts::<account-id>:assumed-role/<role-name>/<numeric-session-id>
  # =>
  #     arn:aws:iam::<account-id>:role/<role-name>
  # This allows a user to simply pass `role_arn = "${data.aws_caller_identity.this.arn}"`
  role_arn = "${replace(var.role_arn, "/(.*):sts:(.*):assumed-role/(.*)/[0-9]*$/", "$1:iam:$2:role/$3")}"

  command = [
    "python",
    "\"${path.module}/ram_principal_association_accepter.py\"",
    "--resource-share-arn",
    "\"${join("", aws_ram_principal_association.this.*.resource_share_arn)}\"",
    "--profile",
    "\"${var.profile}\"",
    "--role-arn",
    "\"${local.role_arn}\"",
    "--region",
    "\"${var.region}\"",
  ]
}
