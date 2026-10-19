locals {
  name_suffix = "${var.project}-${var.environment}"
  # Web App names are global DNS labels; a stable hash of the RG ID keeps them unique without extra providers.
  unique_suffix = substr(md5(azurerm_resource_group.main.id), 0, 6)

  sql_admin_login = "sqladmin"

  # Built from an ephemeral value, so it is ephemeral itself and is only usable in write-only attributes.
  sql_connection_string = join(";", [
    "Server=tcp:${azurerm_mssql_server.main.fully_qualified_domain_name},1433",
    "Initial Catalog=${azurerm_mssql_database.main.name}",
    "User ID=${local.sql_admin_login}",
    "Password=${ephemeral.random_password.sql_admin.result}",
    "Encrypt=True",
    "TrustServerCertificate=False",
    "Connection Timeout=30",
  ])

  tags = {
    env     = var.environment
    owner   = var.owner
    cost    = var.cost_center
    project = var.project
  }
}
