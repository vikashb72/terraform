# -- Required 

# Enviroment dev|uat|prod
variable "environment" {
  type = string
  default = "hub"
}

# az account show | jq -r '.tenantId'
variable "az_tenant_id" {}

variable "vnets" {
  type = list(string)
}

variable "snets" {
  type = map(any)
}

# -- Optional
# Location
variable "az_location" {
  type    = string
  default = "South Africa North"
}

variable "country_code" {
  type    = string
  default = "za"
}

variable "suffix" {
  type    = string
  default = "wherever"
}

variable "storage_containers" {
  type    = list(string)
  default = []
}

variable "user_assigned_identity" {
  type    = list(string)
  default = []
}

variable "storage_accounts" {
  type    = list(any)
  default = []
}
