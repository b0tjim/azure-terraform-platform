variable "project" {
  description = "Short project name used in the vault name."
  type        = string
}

variable "environment" {
  description = "Deployment environment (dev or prod)."
  type        = string
}

variable "name_suffix" {
  description = "Short unique suffix (e.g. 6 random chars). Keeps the global vault name unique and under 24 chars."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group to create the vault in."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "db_password" {
  description = "Database password to store as the db-password secret."
  type        = string
  sensitive   = true
}

variable "purge_protection_enabled" {
  description = "Block permanent deletion during the retention window. Enable in prod."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags applied to the vault."
  type        = map(string)
  default     = {}
}
