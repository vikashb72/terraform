# -- Required 

# Enviroment dev|uat|prod
variable "environment" {
  type = string
}

# az account show | jq -r '.tenantId'
variable "az_tenant_id" {}

# -- Optional

# Location
variable "az_location" {
  type    = string
  default = "South Africa North"
}

variable "suffix" {
  type    = string
  default = "home-wherever"
}

variable "hub" {
  default = {}
}

variable "env" {
  default = {}
}

# Virtual Networks
# Hub Vnet(s)
variable "hub_vnet_subnets" {
  type    = list(string)
  default = []
}

# Hub Network Subnet
variable "hub_subnets" {
  default = {}
}

# Env vnet
variable "env_vnet_subnets" {
  type    = list(string)
  default = []
}

# Env Network Subnet
variable "env_subnets" {
  default = {}
}

# Storage Containers
variable "storage_containers" {
  type    = list(string)
  default = ["logs"]
}
