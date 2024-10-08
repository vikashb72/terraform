variable "environment" {}
variable "az_tenant_id" {}
variable "vnet_subnets" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}
variable "gateway_subnet" {
  type    = string
  default = "10.0.0.0/28"
}
variable "bastion_subnet" {
  type    = string
  default = "10.0.0.16/28"
}
variable "firewall_subnet" {
  type    = string
  default = "10.0.0.32/28"
}
