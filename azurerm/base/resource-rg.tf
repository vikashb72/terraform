resource "azurerm_resource_group" "resource_group" {
  name     = "rg-${var.environment}-${var.suffix}"
  location = var.az_location
}
