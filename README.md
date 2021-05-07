# terraform-aws-tardigrade-ram-principal-association

Terraform module to manage a resource share with AWS Resource Access Manager (RAM)

## Testing

You can find example implementations of this module in the tests folder. Note that the terraform aws
provider configs for the tests require that you use a profiles with the names `resource-owner` and
`resource-member`. Also note that the `cross_account` test requires 2 different AWS accounts.

<!-- BEGIN TFDOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.0 |

## Resources

| Name | Type |
|------|------|

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Name of the resource share | `string` | n/a | yes |
| <a name="input_allow_external_principals"></a> [allow\_external\_principals](#input\_allow\_external\_principals) | Boolean indicating whether principals outside the AWS organization can be associated with the resource share | `bool` | `false` | no |
| <a name="input_principals"></a> [principals](#input\_principals) | List of principals to associate with the resource share. Possible values are an AWS account ID, an AWS Organizations Organization ARN, or an AWS Organizations Organization Unit ARN. | `list(string)` | `[]` | no |
| <a name="input_resources"></a> [resources](#input\_resources) | Schema list of resources to associate to the resource share | <pre>list(object({<br>    name         = string # used as for_each key; cannot be an attribute of a resource in the same tfstate<br>    resource_arn = string # ARN of the resource to associate with the share; *can* be an attribute of a resource in the same tfstate<br>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags to assign to the resource share | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_principal_associations"></a> [principal\_associations](#output\_principal\_associations) | Object with the AWS RAM principal associations resources |
| <a name="output_resource_associations"></a> [resource\_associations](#output\_resource\_associations) | Object with the AWS RAM resource associations resources |
| <a name="output_resource_share"></a> [resource\_share](#output\_resource\_share) | Object with the AWS RAM resource share resource |

<!-- END TFDOCS -->
