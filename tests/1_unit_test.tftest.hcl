mock_provider "azurerm" {
  source = "./tests"
}
run "does_the_name_start_or_end_with_hyphen" {
  command = plan
  assert {
    condition     = substr(azurerm_linux_function_app.function_app.name, 0, 1) != "-"
    error_message = "The name cannot strart with a hyphen"
  }
  assert {
    condition     = substr(azurerm_linux_function_app.function_app.name, -1, -1) != "-"
    error_message = "The name cannot end with a hyphen"
  }
}
run "is_the_name_with_the_correct_resource_description" {
  command = plan
  assert {
    condition     = length(var.resource_description) > 0 ? azurerm_linux_function_app.function_app.name == "func-${var.project}-${var.env}-${var.region_short_name}-${var.resource_description}${length(var.instance) > 0 ? "-${var.instance}" : ""}" : azurerm_linux_function_app.function_app.name == "func-${var.project}-${var.env}-${var.region_short_name}${length(var.instance) > 0 ? "-${var.instance}" : ""}"
    error_message = "The name does not comply with the naming convention"
  }
}
run "is_the_name_with_the_correct_instance" {
  command = plan
  assert {
    condition     = length(var.instance) > 0 ? azurerm_linux_function_app.function_app.name == "func-${var.project}-${var.env}-${var.region_short_name}${length(var.resource_description) > 0 ? "-${var.resource_description}" : ""}-${var.instance}" : azurerm_linux_function_app.function_app.name == "func-${var.project}-${var.env}-${var.region_short_name}${length(var.resource_description) > 0 ? "-${var.resource_description}" : ""}"
    error_message = "The name does not comply with the naming convention"
  }
}
run "is_the_name_correct_when_all_values_pass" {
  command = plan
  variables {
    instance             = 01
    resource_description = "test"
  }
  assert {
    condition     = azurerm_linux_function_app.function_app.name == "func-${var.project}-${var.env}-${var.region_short_name}-${var.resource_description}-${var.instance}"
    error_message = "The name does not comply with the naming convention"
  }
}
run "is_northeurope_the_region_name" {
  command = plan
  assert {
    condition     = azurerm_linux_function_app.function_app.location == "North Europe"
    error_message = "The region is not North Europe"
  }
  assert {
    condition     = var.region_short_name == "euno"
    error_message = "The region short name does not correlate with the region"
  }
}

run "is_canadacentral_the_region_name" {
  command = plan
  variables {
    azure_region      = "Canada Central"
    region_short_name = "cnc"
  }
  assert {
    condition     = azurerm_linux_function_app.function_app.location == "Canada Central"
    error_message = "The region is not Canada Central"
  }
  assert {
    condition     = var.region_short_name == "cnc"
    error_message = "The region short name does not correlate with the region"
  }
}

run "are_all_tags_in_place_and_not_empty" {
  command = plan
  assert {
    condition     = azurerm_linux_function_app.function_app.tags.CostCenter != ""
    error_message = "The Cost Center tag is does not have a valid value"
  }
  assert {
    condition     = azurerm_linux_function_app.function_app.tags.CreatedBy != ""
    error_message = "The Created By tag is does not have a valid value"
  }
  assert {
    condition     = azurerm_linux_function_app.function_app.tags.Owner != ""
    error_message = "The Owner tag is does not have a valid value"
  }
  assert {
    condition     = azurerm_linux_function_app.function_app.tags.Project != ""
    error_message = "The Project tag is does not have a valid value"
  }
  assert {
    condition     = azurerm_linux_function_app.function_app.tags.Scope != ""
    error_message = "The Scope tag is does not have a valid value"
  }
  assert {
    condition     = azurerm_linux_function_app.function_app.tags.Service != ""
    error_message = "The Service tag is does not have a valid value"
  }
}
run "is_the_environment_qa" {
  command = plan
  variables {
    env = "qa"
  }
  assert {
    condition     = var.env == "qa"
    error_message = "The environment is not qa"
  }
}
run "is_enable_builtin_logging_value_set" {
  command = plan
  assert {
    condition     = contains([true, false], azurerm_linux_function_app.function_app.builtin_logging_enabled)
    error_message = "The enable builtin logging value is not correct, should only be true or false"
  }
}
run "is_https_only_value_set" {
  command = plan
  assert {
    condition     = contains([true, false], azurerm_linux_function_app.function_app.https_only)
    error_message = "The https only value is not correct, should only be true or false"
  }
}
run "is_client_certificate_mode_requiered" {
  command = plan
  assert {
    condition     = azurerm_linux_function_app.function_app.client_certificate_mode == "Required"
    error_message = "The client certifacte enabled mode should be required"
  }
}
run "is_ftps_state_ftps_only" {
  command = plan
  assert {
    condition     = azurerm_linux_function_app.function_app.site_config[0].ftps_state == "FtpsOnly"
    error_message = "The ftps state is not Ftps Only"
  }
}
run "is_vnet_route_all_enabled" {
  command = plan
  assert {
    condition     = contains([true, false], azurerm_linux_function_app.function_app.site_config[0].vnet_route_all_enabled)
    error_message = "The vnet route all enabled value is not correct, should only be true or false"
  }
}
run "is_application_stack_for_dotnet_properly_configured" {
  command = plan
  assert {
    condition     = contains(["3.1", "6.0", "7.0", "8.0"], azurerm_linux_function_app.function_app.site_config[0].application_stack[0].dotnet_version)
    error_message = "The dotnet version is not supported"
  }
}

run "is_the_identity_correctly_configured" {
  command = plan
  assert {
    condition     = contains(["SystemAssigned", "UserAssigned", "SystemAssigned, UserAssigned"], azurerm_linux_function_app.function_app.identity[0].type)
    error_message = "The identity does not have a valid value"
  }
}

run "is_public_access_disabled" {
  command = plan
  assert {
    condition     = azurerm_linux_function_app.function_app.public_network_access_enabled == false
    error_message = "The public access is enabled"
  }
}

# run "is_the_function_created_successfully"{
#     command = apply
#     assert{
#         condition = length(azurerm_linux_function_app.function_app.name) >= 2 && length(azurerm_linux_function_app.function_app.name) <=60
#         error_message = "Invalid length of the name. It has to be between 2 and 60 characters"
#     }
# }
