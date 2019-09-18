# terraform-aws-tardigrade-ram-principal-association

Terraform module to share an AWS Resource Access Manager (RAM) resource with another account

## Testing

You can find example implementations of this module in the tests folder. Please note that this module
requires 2 different AWS accounts to test and that the terraform aws provider definitions are assuming
that you will be using a profile with the name `resource-owner` and `resource-member`
