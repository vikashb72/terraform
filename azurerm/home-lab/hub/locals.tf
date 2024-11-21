locals {
  suffix = join("-",
    [
      "${var.environment}",
      "${var.project}",
      "${var.department}",
      "${var.organisation}",
      "${var.region_code}"
    ]
  )

  tags = {
    environment  = var.environment
    organisation = var.organisation
    department   = var.department
    project      = var.project
    region       = var.region
  }
}
