provider "azurerm" {
  features {}

  # Subscription comes from ARM_SUBSCRIPTION_ID (set by azure/login in CI).
  subscription_id = var.subscription_id
}
