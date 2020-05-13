# RAM Principal Association
output "resource_share_arn" {
  description = "ARN of the resource share"
  value       = join("", aws_ram_principal_association.this.*.resource_share_arn)
}

output "principal" {
  description = "Principal associated with the resource share"
  value       = join("", aws_ram_principal_association.this.*.principal)
}

output "share_id" {
  description = "The ID of the resource share as displayed in the console"
  value       = join("", aws_ram_resource_share_accepter.this.*.share_id)
}

output "share_name" {
  description = "The name of the resource share"
  value       = join("", aws_ram_resource_share_accepter.this.*.share_name)
}

output "resources" {
  description = "A list of the resource ARNs shared via the resource share"
  value       = aws_ram_resource_share_accepter.this.*.resources
}
