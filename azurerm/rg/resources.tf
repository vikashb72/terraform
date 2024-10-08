resource "azurerm_resource_group" "resource_group" {
  name     = "rg-${var.environment}-home-where-ever"
  location = "South Africa North"
}
