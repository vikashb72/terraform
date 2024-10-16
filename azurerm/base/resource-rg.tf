resource "azurerm_resource_group" "resource_group" {
  name     = "rg-${var.environment}-${var.az_suffix}"
  location = var.az_location
}
