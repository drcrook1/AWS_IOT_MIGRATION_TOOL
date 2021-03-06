#iot hub

resource "azurerm_iothub" "base" {
  name                = lower("${var.name_prefix}-${var.environment}-${var.region}-${var.random_string_result}")
  resource_group_name = var.resource_group_name
  location            = var.region

  sku {
    name     = var.hub_sku_name
    capacity = var.hub_sku_capacity
  }
}
# iot hub shared access policy

resource "azurerm_iothub_shared_access_policy" "base" {
  name                = "${var.name_prefix}-shared-access-policy"
  resource_group_name = var.resource_group_name
  iothub_name         = azurerm_iothub.base.name

  registry_read = true
}

#iot hub consumer group
resource "azurerm_iothub_consumer_group" "base" {
  name                   = "${var.name_prefix}-consumer-group"
  resource_group_name    = var.resource_group_name
  iothub_name            = azurerm_iothub.base.name
  eventhub_endpoint_name = "events"
}