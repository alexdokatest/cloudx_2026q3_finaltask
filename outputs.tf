output "resource_group_name" {
  description = "Name of the main resource group."
  value       = azurerm_resource_group.main.name
}

output "traffic_manager_fqdn" {
  description = "Public entry point of the application."
  value       = azurerm_traffic_manager_profile.main.fqdn
}
