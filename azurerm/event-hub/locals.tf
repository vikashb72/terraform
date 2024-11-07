locals {
  suffix = "${var.environment}-${var.suffix}"

  tags = {
    environment = "${var.environment}"
  }
}
