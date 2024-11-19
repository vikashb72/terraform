terraform {
  required_version = ">=1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.21"
    }

    azuread = {
      version = ">= 2.26.0"
    }
  }

  #backend "azurerm" {
  #  # Storage
  #  resource_group_name      = "RG-DEMO-TF"
  #  storage_account_name     = "storageaccountdemostf"
  #  container_name           = "terraform"
  #  key                      = "terraform.tfstate"
  #  access_key               = "<storage_account_access_key>" or
  #  sas_token                = "<storage_account_sas_token>"
  #  # Managed Service Identity
  #  use_msi = true
  #  subscription_id          = "<subscription_id>"
  #  tenant_id                = "<tenant_id>"
  #}
}
