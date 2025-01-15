data "azurerm_service_plan" "app_service_plan" {
  name                = var.app_service_plan_name
  resource_group_name = var.service_plan_resource_group_name
}

data "azurerm_storage_account" "storage_account" {
  name                = var.storage_account_name
  resource_group_name = var.storage_resource_group_name
}

data "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.vnet_rg
}

data "azurerm_key_vault" "key_vault" {
  name                = var.keyvault_data.name
  resource_group_name = var.keyvault_data.rg
}
data "azurerm_key_vault_secret" "app_insights_secrets" {
  for_each     = toset(local.insights_secrets)
  name         = each.key
  key_vault_id = data.azurerm_key_vault.key_vault.id
}
data "azurerm_key_vault_secret" "secret_settings" {
  for_each     = toset(var.secret_settings)
  name         = replace(each.key, "_", "-")
  key_vault_id = data.azurerm_key_vault.key_vault.id
}
data "azurerm_key_vault" "devops_kv_id" {
  name                = var.devops_kv_name
  resource_group_name = var.devops_kv_rg_name
}
