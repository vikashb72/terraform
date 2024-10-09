variable "environment" {}
variable "az_tenant_id" {}
variable "acr_sku" {
  type    = string
  default = "Basic"
}
variable "acr_admin_enabled" {
  type        = string
  default     = true
}
variable "acr_zone_redundancy_enabled" {
  type        = string
  default     = false
}
variable "acr_data_endpoint_enabled" {
  type        = string
  default     = false
}
