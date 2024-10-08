output "vnet_name" {
  description = "Specifies the name of the virtual network"
  value       = azurerm_virtual_network.vnet.name
}

output "vnet_id" {
  description = "Specifies the resource id of the virtual network"
  value       = azurerm_virtual_network.vnet.id
}

output "subnet_gateway_id" {
  description = "Specifies the resource id of the gateway subnets"
  value       = azurerm_subnet.gateway.id
}
