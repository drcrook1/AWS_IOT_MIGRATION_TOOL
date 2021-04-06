###
# environment composition
###

resource "azurerm_resource_group" "base" {
  name     = "rg-aws-az-iot-${var.environment}-${var.region}-${random_string.base.result}"
  location = var.region
}

resource "random_string" "base" {
  length      = 5
  min_numeric = 5
  special     = false
}

module "azure_iot_hub" {
  source               = "./modules/azure_iot_hub"
  environment          = var.environment
  region               = var.region
  resource_group_name  = azurerm_resource_group.base.name
  random_string_result = random_string.base.result
  tags                 = var.tags
}