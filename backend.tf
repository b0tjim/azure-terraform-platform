# Partial configuration: the storage account details are supplied at init time
# (see scripts/bootstrap-state.sh and the README), so no names are hard-coded.
terraform {
  backend "azurerm" {
    use_oidc = true # authenticate to the state account with the same OIDC login as the provider
  }
}
