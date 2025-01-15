provider "azurerm" {
  features {}
  skip_provider_registration = true
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "test_rg" {
  name     = "rg-test-sbx-01"
  location = "North Europe"
}

resource "azurerm_storage_account" "test_storage" {
  name                     = "sttestsbxeuno01"
  resource_group_name      = azurerm_resource_group.test_rg.name
  location                 = azurerm_resource_group.test_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_service_plan" "test_service_plan" {
  name                = "plan-test-sbx-01"
  location            = azurerm_resource_group.test_rg.location
  resource_group_name = azurerm_resource_group.test_rg.name
  os_type             = "Linux"
  sku_name            = "P1v2"
}