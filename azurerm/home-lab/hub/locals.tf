locals {
  suffix = "${var.environment}-${var.unit_name}-${var.company_name}"

  tags = {
    environment  = var.environment
    company_name = var.company_name
    unit_name    = var.unit_name
    region       = var.region
  }
}
