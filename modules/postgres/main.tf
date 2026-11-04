resource "azurerm_postgresql_flexible_server" "this" {
  name                          = "psql-${var.project}-${var.environment}"
  resource_group_name           = var.resource_group_name
  location                      = var.location
  version                       = "16"
  sku_name                      = var.sku_name
  storage_mb                    = var.storage_mb
  backup_retention_days         = var.backup_retention_days
  administrator_login           = var.administrator_login
  administrator_password        = var.administrator_password
  public_network_access_enabled = true # shortcut: public + firewall rule is cheapest; use VNet integration for real prod
  tags                          = var.tags

  lifecycle {
    ignore_changes = [zone] # Azure picks the zone; avoids a perpetual diff
  }
}

resource "azurerm_postgresql_flexible_server_database" "this" {
  name      = var.database_name
  server_id = azurerm_postgresql_flexible_server.this.id
  charset   = "UTF8"
  collation = "en_US.utf8"
}

# 0.0.0.0 - 0.0.0.0 is Azure's special range meaning "allow Azure services".
resource "azurerm_postgresql_flexible_server_firewall_rule" "azure_services" {
  name             = "allow-azure-services"
  server_id        = azurerm_postgresql_flexible_server.this.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}
