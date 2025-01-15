locals {
  insights_secrets = concat(["APPLICATIONINSIGHTS-CONNECTION-STRING", "APPINSIGHTS-INSTRUMENTATIONKEY"], var.insights_secrets)
  resource_name    = "func-${var.project}-${var.env}-${var.region_short_name}${length(var.resource_description) > 0 ? "-${var.resource_description}" : ""}${length(var.instance) > 0 ? "-${var.instance}" : ""}"
  secret_settings  = { for settings in var.secret_settings : settings => data.azurerm_key_vault_secret.secret_settings[settings].value }
}
