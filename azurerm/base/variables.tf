# -- Required 

# Enviroment dev|uat|prod
variable "environment" {}

# az account show | jq -r '.tenantId'
variable "az_tenant_id" {}

# -- Optional

# Location
variable "az_location" {
  type    = string
  default = "South Africa North"
}

# Suffix
variable "suffix" {
  type    = string
  default = "home-where-ever"
}

# Virtual Networks
# Management
variable "vnet_subnets" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}
# Gateway Subnet
variable "gateway_subnet" {
  type    = list(string)
  default = ["10.0.0.0/28"]
}
# ACR Subnet
variable "acr_subnet" {
  type    = list(string)
  default = ["10.0.0.16/28"]
}
# KeyVault
variable "kv_subnet" {
  type    = list(string)
  default = ["10.0.0.32/28"]
}
