# App Hosting
# Service plan for blazor webapp

resource "azurerm_service_plan" "this" {
  name                = azurecaf_name.service_plan.result
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  os_type             = "Linux"
  sku_name            = "B1"
  # F1 for free mode, B1 for basic mode.
  # To switch to free mode, delete custom domain manually in portal. Then set always_on to false, and apply that change. Then finally change to F1 and apply that change

  tags = {
    app     = local.appName
    purpose = local.environment
  }

}


resource "azurerm_linux_web_app" "website" {
  name                = azurecaf_name.website.result
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_service_plan.this.location
  service_plan_id     = azurerm_service_plan.this.id

  site_config {
    always_on = true

    application_stack {
      dotnet_version = "9.0"
    }
  }

  auth_settings_v2 {
    auth_enabled           = true
    default_provider       = "google"
    excluded_paths         = ["/", "/*.css", "/favicon.png","/lib/*", "/_framework/*"]
    unauthenticated_action = "RedirectToLoginPage"
    require_authentication = true

    google_v2 {
      client_id                  = var.google_client_id
      client_secret_setting_name = "GOOGLE_PROVIDER_AUTHENTICATION_SECRET"
    }

    login {
      logout_endpoint     = "/.auth/logout"
      token_store_enabled = true

    }
  }
  # These become env vars, which can be read by the config provider (nested properties use : which becomes __ )
  app_settings = {
    GOOGLE_PROVIDER_AUTHENTICATION_SECRET = var.google_client_secret
    # AzureAdB2C__Instance             = "https://cccwebapp.b2clogin.com"
    # AzureAdB2C__Domain               = "cccwebapp.onmicrosoft.com"
    # AzureAdB2C__ClientId             = azuread_application.website.application_id
    # AzureAdB2C__ClientSecret         = azuread_application_password.website.value
    # AzureAdB2C__SignUpSignInPolicyId = "B2C_1_SignupSignin"
    # AzureAdB2C__SignOutCallbackPath  = "/signout/B2C_1_SignupSignin"

    # API__CalledAPIScopes = "${local.api_uri}/${local.api_access_scope}"
    # API__Scope           = "${local.api_uri}/${local.api_access_scope}"
    # API__BaseUrl         = "https://${azurerm_linux_web_app.api.default_hostname}/api/"
  }

  sticky_settings {
    app_setting_names = ["GOOGLE_PROVIDER_AUTHENTICATION_SECRET"]
  }
  logs {
    detailed_error_messages = true
    failed_request_tracing  = true
    http_logs {
      file_system {
        retention_in_days = 4
        retention_in_mb   = 35
      }
    }
  }

}
