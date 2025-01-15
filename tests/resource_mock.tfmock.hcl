override_data {
  target = data.azurerm_service_plan.app_service_plan
  values = {
    id = "/subscriptions/12345678-1234-9876-4563-123456789012/resourceGroups/example-resource-group/providers/Microsoft.Web/serverFarms/service-plan-value"
  }
}
override_data {
  target = data.azurerm_storage_account.storage_account
}
override_data {
  target = data.azurerm_subnet.subnet
  values = {
    id = "/subscriptions/12345678-1234-9876-4563-123456789012/resourceGroups/example-resource-group/providers/Microsoft.Network/virtualNetworks/virtualNetworksValue/subnets/subnetValue"
  }
}
override_data {
  target = data.azurerm_key_vault.key_vault
  values = {
    id = "/subscriptions/12345678-1234-9876-4563-123456789012/resourceGroups/example-resource-group/providers/Microsoft.KeyVault/vaults/keyvault-value"
  }
}
override_data {
  target = data.azurerm_key_vault_secret.app_insights_secrets
}
override_data {
  target = data.azurerm_key_vault_secret.secret_settings
}
override_data {
  target = data.azurerm_key_vault.devops_kv_id
  values = {
    id = "/subscriptions/12345678-1234-9876-4563-123456789012/resourceGroups/example-resource-group/providers/Microsoft.KeyVault/vaults/keyvault-value"
  }
}
