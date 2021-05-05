# terraform-aws-tardigrade-ram-principal-association/cross_account_principal_association

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
| resource\_share\_arn | ARN of the resource share | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| principal\_association | Object with the AWS RAM principal association resource |
| share\_accepter | Object with the AWS RAM share accepter resource |

<!-- END TFDOCS -->
