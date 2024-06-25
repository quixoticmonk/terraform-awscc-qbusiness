<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_awscc"></a> [awscc](#requirement\_awscc) | 1.3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.55.0 |
| <a name="provider_awscc"></a> [awscc](#provider\_awscc) | 1.3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [awscc_iam_role.this](https://registry.terraform.io/providers/hashicorp/awscc/1.3.0/docs/resources/iam_role) | resource |
| [awscc_kms_key.this](https://registry.terraform.io/providers/hashicorp/awscc/1.3.0/docs/resources/kms_key) | resource |
| [awscc_qbusiness_application.this](https://registry.terraform.io/providers/hashicorp/awscc/1.3.0/docs/resources/qbusiness_application) | resource |
| [awscc_qbusiness_index.this](https://registry.terraform.io/providers/hashicorp/awscc/1.3.0/docs/resources/qbusiness_index) | resource |
| [awscc_qbusiness_retriever.this](https://registry.terraform.io/providers/hashicorp/awscc/1.3.0/docs/resources/qbusiness_retriever) | resource |
| [awscc_qbusiness_web_experience.this](https://registry.terraform.io/providers/hashicorp/awscc/1.3.0/docs/resources/qbusiness_web_experience) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_ssoadmin_instances.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssoadmin_instances) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_identity_center_arn"></a> [app\_identity\_center\_arn](#input\_app\_identity\_center\_arn) | Identity Center arn for the app | `string` | `""` | no |
| <a name="input_app_kms_key"></a> [app\_kms\_key](#input\_app\_kms\_key) | KMS key for the app encryption configuration | `string` | `""` | no |
| <a name="input_app_role_arn"></a> [app\_role\_arn](#input\_app\_role\_arn) | Role arn to assume for the app | `string` | `""` | no |
| <a name="input_attribute_config"></a> [attribute\_config](#input\_attribute\_config) | Configuration information for document attributes | <pre>list(object({<br>    Name   = string,<br>    Search = string,<br>    Type   = string<br>  }))</pre> | `null` | no |
| <a name="input_enable_encryption"></a> [enable\_encryption](#input\_enable\_encryption) | Should encryption be enabled ? | `bool` | `false` | no |
| <a name="input_index_type"></a> [index\_type](#input\_index\_type) | The type of index. The valid options are `ENTERPRISE` and `STARTER` | `string` | `"ENTERPRISE"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | prefix to be used for the Qbusiness application components | `string` | `"test"` | no |
| <a name="input_storage_units"></a> [storage\_units](#input\_storage\_units) | The number of storage units configured for an Amazon Q Business index. | `string` | `1` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be attached to the Qbusiness resources | `list(object({ key = string, value = string }))` | <pre>[<br>  {<br>    "key": "Modified By",<br>    "value": "AWSCC"<br>  }<br>]</pre> | no |
| <a name="input_web_exp_subtitle"></a> [web\_exp\_subtitle](#input\_web\_exp\_subtitle) | Value for the QBusiness web experience subtitle | `string` | `"Drop a file and ask questions"` | no |
| <a name="input_web_exp_title"></a> [web\_exp\_title](#input\_web\_exp\_title) | Value for the QBusiness web experience title | `string` | `"Sample Amazon Q Business App"` | no |
| <a name="input_welcome_message"></a> [welcome\_message](#input\_welcome\_message) | Value for the QBusiness web experience welcome message. | `string` | `"Welcome, please enter your questions"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->