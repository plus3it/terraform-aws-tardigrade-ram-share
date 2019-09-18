variable "create_ram_principal_association" {
  description = "Controls whether to create the RAM Principal Association"
  default     = true
}

variable "resource_share_arn" {
  description = "ARN of the resource share"
  type        = string
  default     = null
}

variable "principal" {
  description = "The principal to associate with the resource share. Possible values are an AWS account ID, an AWS Organizations Organization ARN, or an AWS Organizations Organization Unit ARN."
  type        = string
  default     = null
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
  type        = string
  default     = ""
}

variable "role_arn" {
  description = "(Optional) Used by null_resource to assume a role in the accepter account"
  type        = string
  default     = ""
}

variable "region" {
  description = "(Optional) Used by null_resource to establish botocore client"
  type        = string
  default     = null
}
