resource "azurerm_linux_web_app" "this" {
  for_each = azurerm_service_plan.this

  name                = "app-${local.name_suffix}-${each.key}-${local.unique_suffix}"
  resource_group_name = azurerm_resource_group.main.name
  location            = each.value.location
  service_plan_id     = each.value.id
  https_only          = true
  tags                = local.tags

  identity {
    type = "SystemAssigned"
  }

  app_settings = {
    APP_REGION = each.value.location
    APP_CODE   = "require('http').createServer((q,s)=>s.end('Region: '+process.env.APP_REGION)).listen(process.env.PORT||8080)"
  }

  site_config {
    # One-line demo app: no code deployment needed. The code lives in APP_CODE because
    # App Service strips single quotes from the startup command.
    app_command_line = "node -e \"eval(process.env.APP_CODE)\""

    application_stack {
      node_version = "24-lts"
    }
  }
}
