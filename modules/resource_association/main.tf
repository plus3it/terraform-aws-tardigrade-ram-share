resource "aws_ram_resource_association" "this" {
  region             = var.region
  resource_arn       = var.resource_arn
  resource_share_arn = var.resource_share_arn
}
