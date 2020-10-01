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
| terraform | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Name of the resource share | `string` | n/a | yes |
| allow\_external\_principals | Boolean indicating whether principals outside the AWS organization can be associated with the resource share | `bool` | `false` | no |
| principals | List of principals to associate with the resource share. Possible values are an AWS account ID, an AWS Organizations Organization ARN, or an AWS Organizations Organization Unit ARN. | `list(string)` | `[]` | no |
| resources | Schema list of resources to associate to the resource share | <pre>list(object({<br>    name         = string # used as for_each key; cannot be an attribute of a resource in the same tfstate<br>    resource_arn = string # ARN of the resource to associate with the share; *can* be an attribute of a resource in the same tfstate<br>  }))</pre> | `[]` | no |
| tags | Map of tags to assign to the resource share | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| principal\_associations | Object with the AWS RAM principal associations resources |
| resource\_associations | Object with the AWS RAM resource associations resources |
| resource\_share | Object with the AWS RAM resource share resource |

<!-- END TFDOCS -->
