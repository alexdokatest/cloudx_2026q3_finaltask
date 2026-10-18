resource "azurerm_service_plan" "this" {
  for_each = var.app_service_plans

  name                = "asp-${local.name_suffix}-${each.key}"
  resource_group_name = azurerm_resource_group.main.name
  location            = each.value.location
  os_type             = each.value.os_type
  sku_name            = each.value.sku_name
  tags                = local.tags
}
