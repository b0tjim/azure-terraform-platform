variable "subscription_id" {
  description = "Azure subscription ID. Leave null to use ARM_SUBSCRIPTION_ID."
  type        = string
  default     = null
}

variable "environment" {
  description = "Deployment environment name (dev or prod)."
  type        = string

  validation {
    condition     = contains(["dev", "prod"], var.environment)
    error_message = "environment must be \"dev\" or \"prod\"."
  }
}

variable "location" {
  description = "Azure region for all resources."
  type        = string
  default     = "eastus2"
}

variable "project" {
  description = "Short project name used in resource names."
  type        = string
  default     = "bakery"
}

variable "image" {
  description = "Container image to run, e.g. ghcr.io/b0tjim/bakery-orders-api."
  type        = string
  default     = "ghcr.io/b0tjim/bakery-orders-api"
}

variable "image_tag" {
  description = "Image tag to deploy."
  type        = string
  default     = "v0.1.0"
}

variable "tags" {
  description = "Extra tags applied to every resource."
  type        = map(string)
  default     = {}
}

variable "postgres_sku_name" {
  description = "PostgreSQL Flexible Server SKU."
  type        = string
  default     = "B_Standard_B1ms"
}

variable "min_replicas" {
  description = "Minimum app replicas (0 scales to zero)."
  type        = number
  default     = 0
}

variable "max_replicas" {
  description = "Maximum app replicas."
  type        = number
  default     = 1
}
