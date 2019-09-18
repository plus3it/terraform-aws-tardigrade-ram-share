# terraform-aws-tardigrade-ram-principal-association

Terraform module to share an AWS Resource Access Manager (RAM) resource with another account

## Testing

You can find example implementations of this module in the tests folder. Please note that this module
requires 2 different AWS accounts to test and that the terraform aws provider definitions are assuming
that you will be using a profile with the name `resource-owner` and `resource-member`

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| auto\_accept | Controls whether to automatically accept the invite, in case principal is another account | string | `"true"` | no |
| create\_ram\_principal\_association | Controls whether to create the RAM Principal Association | string | `"true"` | no |
| cross\_account | Boolean to indicate whether principal is another account | string | `"true"` | no |
| principal | The principal to associate with the resource share. Possible values are an AWS account ID, an AWS Organizations Organization ARN, or an AWS Organizations Organization Unit ARN. | string | `"null"` | no |
| profile | (Optional) Used by null_resource to establish botocore session | string | `""` | no |
| region | (Optional) Used by null_resource to establish botocore client | string | `"null"` | no |
| resource\_share\_arn | ARN of the resource share | string | `"null"` | no |
| role\_arn | (Optional) Used by null_resource to assume a role in the accepter account | string | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| accepter\_id | ID of the null resource used to accept the share |
| principal | Principal associated with the resource share. |
| resource\_share\_arn | ARN of the resource share |

