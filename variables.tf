variable "azure_region" {
  type        = string
  description = "The Azure region to deploy to. Recommendation is to set to the same location as the resource group."
  default     = "North Europe"
  validation {
    condition     = contains(["North Europe", "Canada Central"], var.azure_region)
    error_message = "The regions must be North Europe or Canada Central"
  }
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name."
}

variable "app_service_plan_name" {
  type        = string
  description = "App service plan name."
}

variable "storage_account_name" {
  type        = string
  description = "Storage account name."
}

variable "func_version" {
  type        = string
  default     = "~4"
  description = "Function app runtime version."
  validation {
    condition     = var.func_version == "~4"
    error_message = "The value for the function version is incorrect"
  }
}

variable "storage_resource_group_name" {
  type        = string
  description = "Storage resource group name."
}

variable "service_plan_resource_group_name" {
  type        = string
  description = "Service plan resource group name."
}

variable "tags" {
  type = map(string)
}

variable "env" {
  type = string
  validation {
    condition     = contains(["sbx", "dev", "qa", "stg", "p"], var.env)
    error_message = "The environment is not valid"
  }
}

variable "instance" {
  type        = string
  description = "Number of function app"
  validation {
    condition     = tonumber(var.instance) > 0
    error_message = "The instance value has to be greater than 0"
  }
}

variable "project" {
  type        = string
  description = "Name of the project that the function app belongs to"
}

variable "resource_description" {
  type        = string
  description = "Name of the project that the function app belongs to"
}

variable "region_short_name" {
  type    = string
  default = "euno"
  validation {
    condition     = contains(["euno", "cnc"], var.region_short_name)
    error_message = "The region short name is not allowed"
  }
}

variable "enable_builtin_logging" {
  type = bool
}

variable "https_only" {
  type = bool
}

variable "app_settings" {
  type = map(string)
}

variable "connection_string" {
  type = list(object({
    name  = string
    value = string
    type  = string
  }))
}

variable "subnet_name" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "vnet_rg" {
  type = string
}

variable "client_certificate_mode" {
  type = string
  validation {
    condition     = contains(["Required", "Optional", "OptionalInteractiveUser"], var.client_certificate_mode)
    error_message = "The value for the client certificate mode is invalid"
  }
}

variable "insights_secrets" {
  type = list(string)
}

variable "ftps_state" {
  type = string
  validation {
    condition     = contains(["AllAllowed", "FtpsOnly", "Disabled"], var.ftps_state)
    error_message = "The ftps state value is incorrect"
  }
}

variable "vnet_route_all_enable" {
  type = bool
}

variable "application_stack" {
  type = map(string)
}
variable "sticky_settings" {
  type = list(object({
    app_setting_names = list(string)
  }))
}

variable "keyvault_data" {
  type = map(string)
}

variable "cors" {
  type = list(object({
    allowed_origins     = list(string)
    support_credentials = bool
  }))
}

variable "ip_restriction" {
  type = map(map(string))
}

variable "app_service_logs" {
  type = list(object({
    disk_quota_mb         = number
    retention_period_days = number
  }))
  default = []
}

variable "devops_kv_name" {
  type = string
}
variable "devops_kv_rg_name" {
  type = string
}

variable "secret_settings" {
  type    = list(string)
  default = []
}
variable "health_check_path" {
  type = string
}

variable "parameters" {
  type        = bool
  description = "To make the parameters optional to store"
  default     = true
}
