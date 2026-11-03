variable "project" {
  description = "Short project name used in the resource group name."
  type        = string
}

variable "environment" {
  description = "Deployment environment (dev or prod)."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "tags" {
  description = "Tags applied to the resource group."
  type        = map(string)
  default     = {}
}
