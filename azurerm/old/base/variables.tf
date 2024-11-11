# -- Required 

# Enviroment dev|uat|prod
variable "environment" {
    type    = string
}

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
  type = list(string)
  default = []
}

# Network Subnetx
variable "subnets" {
  default = {}
}

# Storage account containers to be created
variable "storage_account_containers" {
  type  = list(any)
  default =[
    "terraform-state",
    "logs"
  ]
}

#variable "dns_records" {
#  description = "Settings for DNS records"
#  type = list(object({
#    zone_name   = string
#    record_name = string
#    ttl         = number
#    ip          = string
#  }))
#}

