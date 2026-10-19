terraform {
  # 1.10 brings ephemeral resources, 1.11 the write-only (*_wo) arguments used for the SQL password.
  required_version = ">= 1.11.0"

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
