resource "random_password" "admin_password" {
  # count       = var.sql_db_admin_password == null ? 1 : 0
  length      = 20
  special     = true
  min_numeric = 1
  min_upper   = 1
  min_lower   = 1
  min_special = 1
}

locals {
  admin_password = var.sql_db_admin_password == null ? random_password.admin_password.result : var.sql_db_admin_password
}

resource "azurerm_mssql_server" "server" {
  name                         = azurecaf_name.sql_database.result
  resource_group_name          = azurerm_resource_group.this.name
  location                     = azurerm_resource_group.this.location
  administrator_login          = var.sql_db_admin_username
  administrator_login_password = local.admin_password
  version                      = "12.0"
}

resource "azurerm_mssql_database" "db" {
  name      = azurecaf_name.sql_database.result
  server_id = azurerm_mssql_server.server.id
  sku_name  = "S0"


  lifecycle {
    prevent_destroy = true
  }
}
