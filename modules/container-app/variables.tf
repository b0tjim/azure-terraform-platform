variable "project" {
  description = "Short project name used in resource names."
  type        = string
}

variable "environment" {
  description = "Deployment environment (dev or prod)."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group to create resources in."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "Workspace that receives the environment's container logs."
  type        = string
}

variable "key_vault_id" {
  description = "Key Vault the app's identity may read secrets from."
  type        = string
}

variable "database_url_secret_id" {
  description = "Versionless Key Vault secret ID holding DATABASE_URL."
  type        = string
}

variable "image" {
  description = "Container image without tag, e.g. ghcr.io/b0tjim/bakery-orders-api."
  type        = string
}

variable "image_tag" {
  description = "Image tag to deploy."
  type        = string
}

variable "cpu" {
  description = "vCPU per replica."
  type        = number
  default     = 0.25
}

variable "memory" {
  description = "Memory per replica, e.g. 0.5Gi (must be 2x the vCPU on the Consumption plan)."
  type        = string
  default     = "0.5Gi"
}

variable "min_replicas" {
  description = "Minimum replicas. 0 lets the app scale to zero (cheapest)."
  type        = number
  default     = 0
}

variable "max_replicas" {
  description = "Maximum replicas."
  type        = number
  default     = 1
}

variable "tags" {
  description = "Tags applied to every resource."
  type        = map(string)
  default     = {}
}
