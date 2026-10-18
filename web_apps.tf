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

  site_config {
    application_stack {
      node_version = "20-lts"
    }
  }
}
