data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "this" {
  # Key Vault names are global, max 24 chars: the caller passes a unique suffix.
  name                       = "kv-${var.project}-${var.environment}-${var.name_suffix}"
  resource_group_name        = var.resource_group_name
  location                   = var.location
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  rbac_authorization_enabled = true
  purge_protection_enabled   = var.purge_protection_enabled
  soft_delete_retention_days = 7
  tags                       = var.tags
}

# Whoever runs Terraform (the OIDC identity in CI) needs rights to write the secret.
resource "azurerm_role_assignment" "deployer" {
  scope                = azurerm_key_vault.this.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_key_vault_secret" "db_password" {
  name         = "db-password"
  value        = var.db_password
  content_type = "text/plain"
  key_vault_id = azurerm_key_vault.this.id

  # The role assignment can take a moment to propagate, so create it first.
  depends_on = [azurerm_role_assignment.deployer]
}

# The app reads one DATABASE_URL variable, so the full connection string is stored as a secret.
resource "azurerm_key_vault_secret" "database_url" {
  name         = "database-url"
  value        = var.database_url
  content_type = "text/plain"
  key_vault_id = azurerm_key_vault.this.id

  depends_on = [azurerm_role_assignment.deployer]
}
