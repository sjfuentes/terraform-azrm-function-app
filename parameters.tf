resource "azurerm_key_vault_secret" "secret_principal_id" {
  depends_on   = [azurerm_linux_function_app.function_app]
  for_each     = var.parameters ? { "${local.resource_name}" : "" } : {}
  name         = "kvs-${azurerm_linux_function_app.function_app.name}-pid"
  value        = azurerm_linux_function_app.function_app.identity[0].principal_id
  key_vault_id = data.azurerm_key_vault.devops_kv_id.id
}

resource "azurerm_key_vault_secret" "resource_id" {
  depends_on   = [azurerm_linux_function_app.function_app]
  for_each     = var.parameters ? { "${local.resource_name}" : "" } : {}
  name         = "kvs-${azurerm_linux_function_app.function_app.name}-id"
  value        = azurerm_linux_function_app.function_app.id
  key_vault_id = data.azurerm_key_vault.devops_kv_id.id
}