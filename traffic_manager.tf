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

# App Service binds <profile>.trafficmanager.net to the app by itself when the endpoint is added
# (the binding can be removed only through Traffic Manager), but serves it on Standard tier or higher only.
resource "azurerm_traffic_manager_azure_endpoint" "web_app" {
  for_each = azurerm_linux_web_app.this

  name               = "endpoint-${each.key}"
  profile_id         = azurerm_traffic_manager_profile.main.id
  target_resource_id = each.value.id
  enabled            = true
}
