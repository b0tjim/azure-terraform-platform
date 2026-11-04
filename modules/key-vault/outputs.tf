output "id" {
  description = "Key Vault resource ID."
  value       = azurerm_key_vault.this.id
}

output "name" {
  description = "Key Vault name."
  value       = azurerm_key_vault.this.name
}

output "db_password_secret_id" {
  description = "Versionless ID of the db-password secret (for Container App secret references)."
  value       = azurerm_key_vault_secret.db_password.versionless_id
}
