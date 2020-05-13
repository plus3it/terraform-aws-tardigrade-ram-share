variable "auto_accept" {
  description = "Controls whether to automatically accept the invite, in case principal is another account"
  type        = bool
  default     = true
}

variable "create_ram_principal_association" {
  description = "Controls whether to create the RAM Principal Association"
  type        = bool
  default     = true
}

variable "principal" {
  description = "The principal to associate with the resource share. Possible values are an AWS account ID, an AWS Organizations Organization ARN, or an AWS Organizations Organization Unit ARN."
  type        = string
  default     = null
}

variable "resource_share_arn" {
  description = "ARN of the resource share"
  type        = string
  default     = null
}
