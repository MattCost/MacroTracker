resource "azurecaf_name" "primary-rg" {
  name          = local.appName
  resource_type = "azurerm_resource_group"
  suffixes      = [local.environment]
  clean_input   = true
}

# resource "azurecaf_name" "storage_account" {
#   name          = local.appName
#   resource_type = "azurerm_storage_account"
#   suffixes      = [local.environment]
#   clean_input   = true
# }

resource "azurecaf_name" "service_plan" {
  name          = local.appName
  resource_type = "azurerm_app_service_plan"  # we are really making a service plan, since app_service_plan is deprecated
  suffixes      = [local.environment]
  clean_input   = true
}

resource "azurecaf_name" "website" {
  name = local.appName
  resource_type = "azurerm_app_service"
  suffixes      = ["website", local.environment]
  clean_input   = true
}

resource "azurecaf_name" "sql_server" {
  name = local.appName
  resource_type = "azurerm_mssql_server"
  suffixes = [local.environment]
  clean_input = true  
}

resource "azurecaf_name" "sql_database" {
  name = local.appName
  resource_type = "azurerm_mssql_database"
  suffixes = [local.environment]
  clean_input = true  
}