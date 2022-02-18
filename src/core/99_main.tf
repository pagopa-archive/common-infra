terraform {
  required_version = ">=1.1.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 2.90.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "= 2.10.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.1.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.1.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = false
    }
  }
}

data "azurerm_subscription" "current" {}

data "azurerm_client_config" "current" {}

locals {
  project = format("%s-%s", var.prefix, var.env_short)
}
