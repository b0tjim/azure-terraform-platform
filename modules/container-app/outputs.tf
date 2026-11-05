output "url" {
  description = "Public HTTPS URL of the app."
  value       = "https://${azurerm_container_app.this.ingress[0].fqdn}"
}

output "identity_principal_id" {
  description = "Principal ID of the app's managed identity."
  value       = azurerm_user_assigned_identity.app.principal_id
}
