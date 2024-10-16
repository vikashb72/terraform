# Enviroment dev|uat|prod
variable "environment" {}

# az account show | jq -r '.tenantId'
variable "az_tenant_id" {}

# Location
variable "az_location" {
  type    = string
  default = "South Africa North"
}

# Suffix
variable "az_suffix" {
  type    = string
  default = "home-where-ever"
}
