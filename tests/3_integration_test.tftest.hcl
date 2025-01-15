# provider "azurerm" {
#   features {}
#   skip_provider_registration = true
# }

# run "setup_tests" {
#     module {
#         source = "./tests/setup/resources"
#     }
# }

# run "is_the_function_created_successfully"{
#     command = apply
#     assert{
#         condition = length(azurerm_linux_function_app.function_app.name) >= 2 && length(azurerm_linux_function_app.function_app.name) <=60
#         error_message = "Invalid length of the name. It has to be between 2 and 60 characters"
#     }
# }

# run "is_function_running"{
#   command = plan
#   module {
#     source = "./tests/setup/data"
#   }
#   variables{
#     endpoint = "https://${run.is_the_function_created_successfully.function_app_name}.azurewebsites.net"
#   }
#   assert{
#     condition = data.http.function.status_code == 200 || data.http.function.status_code == 403
#     error_message = "Function responded with HTTP status ${data.http.function.status_code}"
#   }
# }
