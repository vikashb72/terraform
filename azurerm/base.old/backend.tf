#terraform {
#  backend "azurerm" {
#    # Variables may not be used here :(
#    storage_account_name = "sa-${var.environment}-${var.suffix}"
#    container_name       = "terraformstate"
#    key                  = "terraform.tfstate"
#  }
#}
