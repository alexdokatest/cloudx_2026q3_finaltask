terraform {
  required_version = ">= 1.10.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.10.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.7"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-alexdoka-platform-shared"
    storage_account_name = "alexdokatfstateplatform"
    container_name       = "learn"
    key                  = "cloudx-2026q3-finaltask.tfstate"
    use_azuread_auth     = true
  }
}
