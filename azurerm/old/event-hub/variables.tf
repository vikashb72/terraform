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

# subnet_address_prefix
variable "subnet_address_prefix" {
  default = []
}

# Evh Topics
variable "topics" {
   default = []
}
