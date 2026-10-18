resource "random_password" "sql_admin" {
  length  = 32
  special = true
}

resource "azurerm_mssql_server" "main" {
  name                         = "sql-${local.name_suffix}-${local.unique_suffix}"
  resource_group_name          = azurerm_resource_group.main.name
  location                     = azurerm_resource_group.main.location
  version                      = "12.0"
  administrator_login          = local.sql_admin_login
  administrator_login_password = random_password.sql_admin.result
  minimum_tls_version          = "1.2"
  tags                         = local.tags
}

resource "azurerm_mssql_database" "main" {
  name         = "sqldb-${local.name_suffix}"
  server_id    = azurerm_mssql_server.main.id
  sku_name     = var.sql_database_sku
  max_size_gb  = var.sql_database_max_size_gb
  license_type = null
  # Default is geo-redundant backup storage, which is not provisionable in this region (and costs more).
  storage_account_type = "Local"
  tags                 = local.tags
}

# 0.0.0.0 - 0.0.0.0 is the special range that allows access from Azure services (the Web Apps).
resource "azurerm_mssql_firewall_rule" "allow_azure_services" {
  name             = "AllowAzureServices"
  server_id        = azurerm_mssql_server.main.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}
