resource "azurerm_storage_container" "tf_state_storage_container" {
  name                  = "tf-state-sc-${var.environment}-${var.suffix}"
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = "private"

  lifecycle {
    prevent_destroy = true
  }

  depends_on = [
    azurerm_storage_account.storage_account
  ]
}


