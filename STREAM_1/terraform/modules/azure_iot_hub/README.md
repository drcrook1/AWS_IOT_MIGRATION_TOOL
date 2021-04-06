## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| azurerm | n/a |

## Modules

No Modules.

## Resources

| Name |
|------|
| [azurerm_iothub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub) |
| [azurerm_iothub_consumer_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub_consumer_group) |
| [azurerm_iothub_dps](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub_dps) |
| [azurerm_iothub_shared_access_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub_shared_access_policy) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| dps\_sku\_capacity | (Required) The number of provisioned IoT Device Provisioning Service units. | `string` | `1` | no |
| dps\_sku\_name | (Required) The name of the sku. Currently can only be set to S1. | `string` | `"S1"` | no |
| environment | Development environment for resource; prod, non-prod, shared-services | `string` | n/a | yes |
| hub\_sku\_capacity | (Required) The number of provisioned IoT Hub units. | `string` | `1` | no |
| hub\_sku\_name | (Required) The name of the sku. Possible values are B1, B2, B3, F1, S1, S2, and S3. | `string` | `"S1"` | no |
| name\_prefix | A short pre-defined text to identify the resource type | `string` | `"iot-hub"` | no |
| random\_string\_result | The generated random string. | `string` | n/a | yes |
| region | Geographic Region resource will be deployed into | `string` | n/a | yes |
| resource\_group\_name | (Required) The Name of this Resource Group. | `string` | n/a | yes |
| service\_name | Name of the application, service, or workload the resource group is housing. | `string` | `"iot"` | no |
| tags | A map of tags to add to all resources | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| iothub\_consumer\_group | n/a |
| iothub\_id | n/a |
| iothub\_shared\_access\_policy\_name | n/a |