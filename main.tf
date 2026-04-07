resource "aws_ram_resource_share" "this" {
  name   = var.name
  region = var.region
  tags   = var.tags

  allow_external_principals = var.allow_external_principals
}

module "resource_associations" {
  source   = "./modules/resource_association"
  for_each = { for resource in var.resources : resource.name => resource }

  region             = var.region
  resource_arn       = each.value.resource_arn
  resource_share_arn = aws_ram_resource_share.this.arn
}

module "principal_associations" {
  source   = "./modules/principal_association"
  for_each = toset(var.principals)

  principal          = each.value
  region             = var.region
  resource_share_arn = aws_ram_resource_share.this.arn
}
