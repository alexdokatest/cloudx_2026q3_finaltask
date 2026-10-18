resource "azurerm_resource_group" "main" {
  name     = "rg-${local.name_suffix}"
  location = var.primary_location
  tags     = local.tags
}
