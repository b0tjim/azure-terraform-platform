output "app_url" {
  description = "Public HTTPS URL of the bakery-orders-api."
  value       = module.container_app.url
}

output "key_vault_name" {
  description = "Key Vault holding the database secrets."
  value       = module.key_vault.name
}

output "resource_group_name" {
  description = "Resource group containing everything."
  value       = module.resource_group.name
}
