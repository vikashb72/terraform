locals {
  suffix = "wherever-lab-${var.environment}-mgmt-${var.country_code}-01"
  tags = {
    environment = "${var.environment}"
    location    = "${var.country_code}"
    component   = "mgmt"
  }
}
