# RAM Principal Association
output "resource_share_arn" {
  description = "ARN of the resource share"
  value       = "${join("", aws_ram_principal_association.this.*.resource_share_arn)}"
}

output "principal" {
  description = "Principal associated with the resource share."
  value       = "${join("", aws_ram_principal_association.this.*.principal)}"
}

output "accepter_id" {
  description = "ID of the null resource used to accept the share"
  value       = "${join("", null_resource.this.*.id)}"
}
