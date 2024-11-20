variable "google_client_id" {
  type = string
}

variable "google_client_secret" {
  type      = string
  sensitive = true

}

variable "sql_db_admin_username" {
  type = string
  default = "admin_sql"  
}

variable "sql_db_admin_password" {
  type = string
  sensitive = true
  default = null
}


variable "sql_db_admin_azuread_username" {
  type = string
}

variable "sql_db_admin_azuread_objectid" {
  type = string
}