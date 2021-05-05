# terraform-aws-tardigrade-ram-principal-association/resource_association

<!-- BEGIN TFDOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| aws | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| resource\_arn | ARN of the resource to associate with the RAM Resource Share | `string` | n/a | yes |
| resource\_share\_arn | ARN of the resource share | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| resource\_association | Object with the AWS RAM resource association resource |

<!-- END TFDOCS -->
