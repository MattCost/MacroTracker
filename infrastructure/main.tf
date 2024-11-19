# Configure the Azure provider
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state-eastus2"
    storage_account_name = "stterraformcirruslyiot"
    container_name       = "macro-tracker"
    key                  = "development.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.10"
    }


    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = "2.0.0-preview3"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
  subscription_id = "4bfb7d87-6480-4af6-94ee-2682a666d3a8"
}


# A Single RG that holds everything
resource "azurerm_resource_group" "this" {
  name     = azurecaf_name.primary-rg.result
  location = local.location

  tags = {
    app     = local.appName
    purpose = local.environment
  }
}
