variable "project" {
  description = "Short project name used in the server name."
  type        = string
}

variable "environment" {
  description = "Deployment environment (dev or prod)."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group to create the server in."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "sku_name" {
  description = "Flexible Server SKU, e.g. B_Standard_B1ms (burstable, cheapest)."
  type        = string
  default     = "B_Standard_B1ms"
}

variable "storage_mb" {
  description = "Storage size in MB (32768 is the minimum)."
  type        = number
  default     = 32768
}

variable "backup_retention_days" {
  description = "Backup retention in days (7-35)."
  type        = number
  default     = 7
}

variable "administrator_login" {
  description = "Admin username."
  type        = string
  default     = "bakeryadmin"
}

variable "administrator_password" {
  description = "Admin password. Generated in the root module and stored in Key Vault."
  type        = string
  sensitive   = true
}

variable "database_name" {
  description = "Application database to create."
  type        = string
  default     = "bakery"
}

variable "tags" {
  description = "Tags applied to the server."
  type        = map(string)
  default     = {}
}
