# terraform-aws-tardigrade-ram-principal-association

Terraform module to share an AWS Resource Access Manager (RAM) resource with another account

## Testing

You can find example implementations of this module in the tests folder. Please note that this module
requires 2 different AWS accounts to test and that the terraform aws provider definitions are assuming
that you will be using a profile with the name `resource-owner` and `resource-member`


<!-- BEGIN TFDOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| aws.owner | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| auto\_accept | Controls whether to automatically accept the invite, in case principal is another account | `bool` | `true` | no |
| create\_ram\_principal\_association | Controls whether to create the RAM Principal Association | `bool` | `true` | no |
| principal | The principal to associate with the resource share. Possible values are an AWS account ID, an AWS Organizations Organization ARN, or an AWS Organizations Organization Unit ARN. | `string` | `null` | no |
| resource\_share\_arn | ARN of the resource share | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| principal | Principal associated with the resource share |
| resource\_share\_arn | ARN of the resource share |
| resources | A list of the resource ARNs shared via the resource share |
| share\_id | The ID of the resource share as displayed in the console |
| share\_name | The name of the resource share |

<!-- END TFDOCS -->
