variable "principal" {
  description = "The principal to associate with the resource share. Possible values are an AWS account ID, an AWS Organizations Organization ARN, or an AWS Organizations Organization Unit ARN."
  type        = string
}

variable "resource_share_arn" {
  description = "ARN of the resource share"
  type        = string
}

variable "region" {
  description = "AWS region where the RAM Share is located (if different from the provider region)"
  type        = string
  default     = null
}
