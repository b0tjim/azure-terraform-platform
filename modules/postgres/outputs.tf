output "fqdn" {
  description = "Server hostname."
  value       = azurerm_postgresql_flexible_server.this.fqdn
}

output "database_name" {
  description = "Application database name."
  value       = azurerm_postgresql_flexible_server_database.this.name
}

output "administrator_login" {
  description = "Admin username."
  value       = azurerm_postgresql_flexible_server.this.administrator_login
}
