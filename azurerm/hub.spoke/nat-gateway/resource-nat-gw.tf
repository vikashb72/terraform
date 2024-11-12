# Create NAT GW Subnet
resource "azurerm_subnet" "env_snet" {
  name                  = "snet-nat-gw-${local.env.suffix}"
  resource_group_name   = data.azurerm_resource_group.env_rg.name
  virtual_network_name  = data.azurerm_virtual_network.env_vnet.name
  address_prefixes      = var.nat_subnet

  depends_on = [
    data.azurerm_resource_group.env_rg,
    data.azurerm_virtual_network.env_vnet
  ]
}

resource "azurerm_public_ip_prefix" "nat_prefix" {
  name                = "pipp-nat-gw-${local.env.suffix}"
  resource_group_name = data.azurerm_resource_group.env_rg.name
  location            = data.azurerm_resource_group.env_rg.location
  ip_version          = "IPv4"
  prefix_length       = 29
  sku                 = "Standard"
  zones               = ["1"]

  depends_on = [
    data.azurerm_resource_group.env_rg,
    data.azurerm_virtual_network.env_vnet,
    azurerm_subnet.env_snet
  ]
}

resource "azurerm_lb" "lb" {
  name                = "lb-nat-gw-${local.env.suffix}"
  sku                 = "Standard"
  location            = azurerm_resource_group.env_rg.location
  resource_group_name = azurerm_resource_group.env_rg.name

  frontend_ip_configuration {
    name                 = azurerm_public_ip.nat_prefix.name
    public_ip_address_id = azurerm_public_ip.nat_prefix.id
  }
}

resource "azurerm_nat_gateway" "instance_gw" {
  name                    = "nat-gw-${local.env.suffix}"
  resource_group_name     = data.azurerm_resource_group.env_rg.name
  location                = data.azurerm_resource_group.env_rg.location
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
  zones                   = ["1"]

  depends_on = [
    data.azurerm_resource_group.env_rg,
    data.azurerm_virtual_network.env_vnet,
    azurerm_subnet.env_snet
  ]
}

resource "azurerm_nat_gateway_public_ip_prefix_association" "nat_ips" {
  nat_gateway_id      = azurerm_nat_gateway.instance_gw.id
  public_ip_prefix_id = azurerm_public_ip_prefix.nat_prefix.id

  depends_on = [
    data.azurerm_resource_group.env_rg,
    data.azurerm_virtual_network.env_vnet,
    azurerm_subnet.env_snet
  ]
}

resource "azurerm_subnet_nat_gateway_association" "sn_cluster_nat_gw" {
  subnet_id      = azurerm_subnet.env_snet.id
  nat_gateway_id = azurerm_nat_gateway.instance_gw.id

  depends_on = [
    data.azurerm_resource_group.env_rg,
    data.azurerm_virtual_network.env_vnet,
    azurerm_subnet.env_snet
  ]
}

# SNET OUTPUTS
output "nat_snet_name" {
  value = azurerm_subnet.env_snet.name
}

output "nat_snet_id" {
  value = azurerm_subnet.env_snet.id
}

output "nat_snet_address_prefixes" {
  value =  azurerm_subnet.env_snet.address_prefixes
}

output "gateway_ips" {
  value = azurerm_public_ip_prefix.nat_prefix.ip_prefix
}
