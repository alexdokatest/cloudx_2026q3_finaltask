resource "azurerm_traffic_manager_profile" "main" {
  name                   = "tm-${local.name_suffix}"
  resource_group_name    = azurerm_resource_group.main.name
  traffic_routing_method = var.traffic_manager_routing_method
  tags                   = local.tags

  dns_config {
    # Becomes <relative_name>.trafficmanager.net, which is global, hence the unique suffix.
    relative_name = "tm-${local.name_suffix}-${local.unique_suffix}"
    ttl           = var.traffic_manager_dns_ttl
  }

  monitor_config {
    protocol                     = "HTTPS"
    port                         = 443
    path                         = "/"
    interval_in_seconds          = 30
    timeout_in_seconds           = 10
    tolerated_number_of_failures = 3
  }
}

resource "azurerm_traffic_manager_azure_endpoint" "web_app" {
  for_each = azurerm_linux_web_app.this

  name               = "endpoint-${each.key}"
  profile_id         = azurerm_traffic_manager_profile.main.id
  target_resource_id = each.value.id
  enabled            = true
}

# Traffic Manager only answers DNS, so the browser sends Host: <profile>.trafficmanager.net to the Web App.
# The app rejects hosts it does not know (404), hence the hostname must be bound to every Web App.
resource "azurerm_app_service_custom_hostname_binding" "traffic_manager" {
  for_each = azurerm_linux_web_app.this

  hostname            = azurerm_traffic_manager_profile.main.fqdn
  app_service_name    = each.value.name
  resource_group_name = azurerm_resource_group.main.name

  # Azure validates the binding by resolving the hostname to the app, which needs the endpoints to exist first.
  depends_on = [azurerm_traffic_manager_azure_endpoint.web_app]
}
