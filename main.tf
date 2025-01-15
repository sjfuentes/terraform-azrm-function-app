resource "azurerm_linux_function_app" "function_app" {
  name                          = local.resource_name
  location                      = var.azure_region
  resource_group_name           = var.resource_group_name
  service_plan_id               = data.azurerm_service_plan.app_service_plan.id
  storage_account_name          = data.azurerm_storage_account.storage_account.name
  storage_account_access_key    = data.azurerm_storage_account.storage_account.primary_access_key
  virtual_network_subnet_id     = data.azurerm_subnet.subnet.id
  public_network_access_enabled = false

  functions_extension_version = var.func_version
  builtin_logging_enabled     = var.enable_builtin_logging
  https_only                  = var.https_only

  client_certificate_mode = var.client_certificate_mode


  site_config {
    application_insights_connection_string = data.azurerm_key_vault_secret.app_insights_secrets["APPLICATIONINSIGHTS-CONNECTION-STRING"].value
    application_insights_key               = data.azurerm_key_vault_secret.app_insights_secrets["APPINSIGHTS-INSTRUMENTATIONKEY"].value
    ftps_state                             = var.ftps_state
    vnet_route_all_enabled                 = var.vnet_route_all_enable

    dynamic "app_service_logs" {
      for_each = var.app_service_logs
      content {
        disk_quota_mb         = app_service_logs.value["disk_quota_mb"]
        retention_period_days = app_service_logs.value["retention_period_days"]
      }
    }


    application_stack {
      dotnet_version              = lookup(var.application_stack, "dotnet_version", null)
      use_dotnet_isolated_runtime = lookup(var.application_stack, "use_dotnet_isolated_runtime", null)
      java_version                = lookup(var.application_stack, "java_version", null)
      node_version                = lookup(var.application_stack, "node_version", null)
      python_version              = lookup(var.application_stack, "python_version", null)
      powershell_core_version     = lookup(var.application_stack, "powershell_core_version", null)
      use_custom_runtime          = lookup(var.application_stack, "use_custom_runtime", null)
    }

    dynamic "cors" {
      for_each = var.cors
      content {
        allowed_origins     = cors.value["allowed_origins"]
        support_credentials = cors.value["support_credentials"]
      }
    }

    dynamic "ip_restriction" {
      for_each = var.ip_restriction
      content {
        action      = ip_restriction.value.action
        name        = ip_restriction.key
        service_tag = ip_restriction.value.service_tag
        priority    = ip_restriction.value.priority
      }
    }
  }

  dynamic "sticky_settings" {
    for_each = var.sticky_settings
    content {
      app_setting_names = sticky_settings.value["app_setting_names"]
    }
  }
  identity {
    type = "SystemAssigned"
  }

  app_settings = merge(var.app_settings, local.secret_settings)

  dynamic "connection_string" {
    for_each = var.connection_string
    content {
      name  = connection_string.value.name
      value = connection_string.value.value
      type  = connection_string.value.type
    }
  }

  tags = merge({ Name = "${local.resource_name}" }, var.tags)
}
