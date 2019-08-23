variable "create_ram_principal_association" {
  description = "Controls whether to create the RAM Principal Association"
  default     = true
}

variable "resource_share_arn" {
  description = "ARN of the resource share"
  default     = ""
  type        = "string"
}

variable "principal" {
  description = "The principal to associate with the resource share. Possible values are an AWS account ID, an AWS Organizations Organization ARN, or an AWS Organizations Organization Unit ARN."
  default     = ""
  type        = "string"
}

variable "cross_account" {
  description = "Boolean to indicate whether principal is another account"
  default     = true
}

variable "auto_accept" {
  description = "Controls whether to automatically accept the invite, in case principal is another account"
  default     = true
}

variable "profile" {
  description = "(Optional) Used by null_resource to establish botocore session"
  default     = ""
  type        = "string"
}

variable "role_arn" {
  description = "(Optional) Used by null_resource to assume a role in the accepter account"
  default     = ""
  type        = "string"
}

variable "region" {
  description = "(Optional) Used by null_resource to establish botocore client"
  default     = ""
  type        = "string"
}
