locals {
  name_suffix = "${var.project}-${var.environment}"
  # Web App names are global DNS labels; a stable hash of the RG ID keeps them unique without extra providers.
  unique_suffix = substr(md5(azurerm_resource_group.main.id), 0, 6)

  sql_admin_login = "sqladmin"

  tags = {
    env     = var.environment
    owner   = var.owner
    cost    = var.cost_center
    project = var.project
  }
}
