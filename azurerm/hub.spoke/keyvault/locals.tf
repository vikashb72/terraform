locals {

  hub = {
    suffix = "hub-${var.environment}-${var.suffix}",
    tags = {
      environment = "hub-${var.environment}"
    }
  }

  env = {
    suffix = "${var.environment}-${var.suffix}",
    tags = {
      environment = "${var.environment}"
    }
  }
}
