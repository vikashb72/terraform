resource "azurerm_resource_group" "resource_group" {
  name     = "rg-${local.suffix}"
  location = var.region

  tags = local.tags
}
