output "iothub_shared_access_policy_name" {
  value = azurerm_iothub_shared_access_policy.base.name
}

output "iothub_consumer_group" {
  value = azurerm_iothub_consumer_group.base.name
}

output "iothub_id" {
  value = azurerm_iothub.base.id
}

output "iothub_name" {
  value = azurerm_iothub.base.name
}