resource "azurerm_user_assigned_identity" "user_assigned_identity" {
  for_each            = toset(var.user_assigned_identity)
  name                = format("uai-%s-%s", each.key, local.suffix)
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
}
