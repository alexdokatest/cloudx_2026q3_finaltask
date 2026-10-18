variable "subscription_id" {
  description = "Azure subscription ID."
  type        = string
  default     = "e9b8a2e4-959a-4222-92b0-33f67ce457e7"
}

variable "project" {
  description = "Short project name, used in resource names and tags."
  type        = string
  default     = "cloudx-2026q3-finaltask"
}

variable "environment" {
  description = "Environment name, used in resource names and tags."
  type        = string
  default     = "dev"
}

variable "owner" {
  description = "Owner tag value."
  type        = string
  default     = "alex-doka"
}

variable "cost_center" {
  description = "Cost tag value."
  type        = string
  default     = "learning"
}

variable "primary_location" {
  description = "Primary region (Web App 1, Azure SQL, Key Vault, resource group)."
  type        = string
  default     = "eastus"
}

variable "secondary_location" {
  description = "Secondary region (Web App 2)."
  type        = string
  default     = "centralus"
}
