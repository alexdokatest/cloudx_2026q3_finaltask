data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "main" {
  name                = "${var.key_vault_name_prefix}-${var.environment}-${local.unique_suffix}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = var.key_vault_sku_name

  # Access policies are required by the task, so RBAC authorization stays off.
  rbac_authorization_enabled = false

  # Learning stand: allow the vault name to be reused right after destroy.
  soft_delete_retention_days = 7
  purge_protection_enabled   = false

  tags = local.tags
}

# The identity running Terraform needs data plane access to create secrets.
resource "azurerm_key_vault_access_policy" "terraform" {
  key_vault_id = azurerm_key_vault.main.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  secret_permissions = ["Get", "List", "Set", "Delete", "Recover", "Purge"]
}

# Each Web App reads secrets through its system-assigned identity (read-only).
resource "azurerm_key_vault_access_policy" "web_app" {
  for_each = azurerm_linux_web_app.this

  key_vault_id = azurerm_key_vault.main.id
  tenant_id    = each.value.identity[0].tenant_id
  object_id    = each.value.identity[0].principal_id

  secret_permissions = ["Get", "List"]
}
