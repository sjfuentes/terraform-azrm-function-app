mock_provider "azurerm" {
  source = "./tests"
}

run "is_azure_region_invalid" {
  command = plan
  variables {
    azure_region = "West Europe"
  }
  expect_failures = [var.azure_region]
}

run "is_region_short_name_invalid" {
  command = plan
  variables {
    region_short_name = "euwe"
  }
  expect_failures = [var.region_short_name]
}

run "is_function_version_invalid" {
  command = plan
  variables {
    func_version = "~5"
  }
  expect_failures = [var.func_version]
}
run "is_environment_valid" {
  command = plan
  variables {
    env = "dummy"
  }
  expect_failures = [var.env]
}
run "is_the_instance_value_greater_than_zero" {
  command = plan
  variables {
    instance = -45
  }
  expect_failures = [var.instance]
}
run "is_the_client_certificate_mode_invalid" {
  command = plan
  variables {
    client_certificate_mode = "OptionalInteractiveUsers"
  }
  expect_failures = [var.client_certificate_mode]
}
run "is_the_ftps_state_value_incorrect" {
  command = plan
  variables {
    ftps_state = "Not Allowed"
  }
  expect_failures = [var.ftps_state]
}
