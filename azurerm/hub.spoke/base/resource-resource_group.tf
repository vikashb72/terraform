resource "azurerm_resource_group" "resource_group" {
  name     = "rg-${local.env.suffix}"
  location = var.az_location

  tags = local.env.tags
}
