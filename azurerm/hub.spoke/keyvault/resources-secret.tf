# generate random password for postgreSQL admin password
#resource "random_password" "psql_admin_password" {
#  length           = 20
#  special          = true
#  lower            = true
#  upper            = true
#  override_special = "!#$" //"!#$%&*()-_=+[]{}<>:?"
#}
#
## Create key vault secret for postgres database password
#resource "azurerm_key_vault_secret" "secret_1" {
#  name         = "postgres-db-password"
#  value        = random_password.psql_admin_password.result
#  key_vault_id = azurerm_key_vault.kv.id
#  tags         = {}
#  depends_on = [
#    azurerm_key_vault.kv,
#  ]
#}
