# output "storage_account_name" {
#   value = azurecaf_name.storage_account.result
# }

output "app_service_plan_name" {
  value = azurecaf_name.service_plan.result
}

output "website_name" {
  value = azurecaf_name.website.result
}

output "sql_database_name" {
  value = azurecaf_name.sql_database.result
}

output "sql_server_name" {
  value = azurecaf_name.sql_server.result
}

output "sql_server_admin_password" {
  value = local.admin_password
  sensitive = true
}