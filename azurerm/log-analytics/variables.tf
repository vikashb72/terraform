variable "environment" {}
variable "az_tenant_id" {}
variable "solution_plan_map" {
  description = "(Required) Specifies solutions to deploy to log analytics workspace"
  type        = map(any)
  default     = {
      ContainerInsight   product   = "OMSGallery/ContainerInsights"
      publisher = "Microsoft"
    }
  }
}
