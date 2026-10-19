variable "subscription_id" {
  description = "Azure subscription ID."
  type        = string
}

variable "project" {
  description = "Short project name, used in resource names and tags."
  type        = string
}

variable "environment" {
  description = "Environment name, used in resource names and tags."
  type        = string
}

variable "owner" {
  description = "Owner tag value."
  type        = string
}

variable "cost_center" {
  description = "Cost tag value."
  type        = string
}

variable "primary_location" {
  description = "Primary region (resource group, Azure SQL, Key Vault)."
  type        = string
}

variable "app_service_plans" {
  description = "App Service Plans keyed by a short name. B1 is the cheapest SKU supported by Traffic Manager and Key Vault references."
  type = map(object({
    location = string
    sku_name = string
    os_type  = optional(string, "Linux")
  }))
}

variable "sql_database_sku" {
  description = "Azure SQL Database SKU. Basic is the cheapest option."
  type        = string
}

variable "sql_database_max_size_gb" {
  description = "Azure SQL Database max size in GB."
  type        = number
}

variable "key_vault_name_prefix" {
  description = "Key Vault name prefix. The full name is <prefix>-<environment>-<unique suffix> and must stay within 24 characters."
  type        = string
}

variable "key_vault_sku_name" {
  description = "Key Vault SKU (standard or premium)."
  type        = string
}

variable "sql_connection_secret_name" {
  description = "Name of the Key Vault secret that holds the SQL connection string."
  type        = string
}

variable "sql_password_version" {
  description = "Bump to rotate the SQL admin password (applied to the server and the Key Vault secret together)."
  type        = number
}

variable "traffic_manager_routing_method" {
  description = "Traffic Manager routing method (Performance routes to the endpoint with the lowest latency)."
  type        = string
}

variable "traffic_manager_dns_ttl" {
  description = "DNS TTL in seconds for the Traffic Manager profile."
  type        = number
}
