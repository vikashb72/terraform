resource "azurerm_resource_group" "resource_group" {
  name     = "rg-${local.suffix}"
  location = var.az_location

  tags = local.tags
}
