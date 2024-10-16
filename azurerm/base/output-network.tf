output "vnet_name" {
  description = "Specifies the name of the virtual network"
  value       = azurerm_virtual_network.vnet.name
}

output "vnet_id" {
  description = "Specifies the resource id of the virtual network"
  value       = azurerm_virtual_network.vnet.id
}

output "subnet_gateway_name" {
  description = "Specifies the resource id of the gateway subnets"
  value       = azurerm_subnet.snet_gateway.name
}

output "subnet_gateway_id" {
  description = "Specifies the resource id of the gateway subnets"
  value       = azurerm_subnet.snet_gateway.id
}

output "subnet_acr_name" {
  description = "Specifies the resource id of the acr subnets"
  value       = azurerm_subnet.snet_acr.name
}

output "subnet_acr_id" {
  description = "Specifies the resource id of the acr subnets"
  value       = azurerm_subnet.snet_acr.id
}

output "subnet_kv_name" {
  description = "Specifies the resource id of the kv subnets"
  value       = azurerm_subnet.snet_kv.name
}

output "subnet_kv_id" {
  description = "Specifies the resource id of the kv subnets"
  value       = azurerm_subnet.snet_kv.id
}
