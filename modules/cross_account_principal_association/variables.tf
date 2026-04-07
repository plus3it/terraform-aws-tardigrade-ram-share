variable "resource_share_arn" {
  description = "ARN of the resource share"
  type        = string
}

variable "region" {
  description = "AWS region where the RAM Share is located (if different from the provider region)"
  type        = string
  default     = null
}
