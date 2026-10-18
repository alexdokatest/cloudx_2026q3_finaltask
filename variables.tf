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
