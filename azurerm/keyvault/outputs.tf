output "subnet_kv_name" {
  description = "Specifies the resource id of the kv subnets"
  value       = azurerm_subnet.snet_kv.name
}

output "subnet_kv_id" {
  description = "Specifies the resource id of the kv subnets"
  value       = azurerm_subnet.snet_kv.id
}                                                                               
