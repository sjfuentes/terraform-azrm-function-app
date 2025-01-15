resource "azurerm_role_assignment" "key_vault" {
  scope                = azurerm_resource_group.test_rg.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_key_vault" "test_kv" {
  depends_on                 = [azurerm_role_assignment.key_vault]
  name                       = "kv-test-sbx-01"
  location                   = azurerm_resource_group.test_rg.location
  resource_group_name        = azurerm_resource_group.test_rg.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days = 7
  purge_protection_enabled   = false
  sku_name                   = "standard"
  enable_rbac_authorization  = true
}
resource "azurerm_key_vault_secret" "secret1" {
  name         = "LoggingMechanism"
  value        = "dummysecret"
  key_vault_id = azurerm_key_vault.test_kv.id
}
resource "azurerm_key_vault_secret" "secret2" {
  name         = "ServiceName"
  value        = "dummysecret"
  key_vault_id = azurerm_key_vault.test_kv.id
}
resource "azurerm_key_vault_secret" "secret3" {
  name         = "MICROSOFT-PROVIDER-AUTHENTICATION-SECRET"
  value        = "dummysecret"
  key_vault_id = azurerm_key_vault.test_kv.id
}
resource "azurerm_key_vault_secret" "secret4" {
  name         = "APPLICATIONINSIGHTS-CONNECTION-STRING"
  value        = "dummysecret"
  key_vault_id = azurerm_key_vault.test_kv.id
}
resource "azurerm_key_vault_secret" "secret5" {
  name         = "APPINSIGHTS-INSTRUMENTATIONKEY"
  value        = "dummysecret"
  key_vault_id = azurerm_key_vault.test_kv.id
}

resource "azurerm_key_vault" "devops_test_kv" {
  depends_on                 = [azurerm_role_assignment.key_vault]
  name                       = "kv-test-sbx-devops-01"
  location                   = azurerm_resource_group.test_rg.location
  resource_group_name        = azurerm_resource_group.test_rg.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days = 7
  purge_protection_enabled   = false
  sku_name                   = "standard"
  enable_rbac_authorization  = true
}
