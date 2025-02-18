terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.0"
    }
  }
}

# Configure the Azure Provider
provider "azurerm" {
  features {}
  skip_provider_registration = true
}