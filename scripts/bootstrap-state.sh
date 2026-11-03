#!/usr/bin/env bash
# One-time setup of the Azure Storage account that holds Terraform remote state.
# Requires: az CLI logged in (az login) with rights to create resources.
# Usage: scripts/bootstrap-state.sh [location]
set -euo pipefail

LOCATION="${1:-eastus2}"
RG="${STATE_RG:-rg-bakery-tfstate}"
# Storage account names are global, 3-24 lowercase alphanumerics: add a stable suffix.
SUFFIX="$(az account show --query id -o tsv | tr -d '-' | cut -c1-8)"
SA="${STATE_SA:-stbakerytf${SUFFIX}}"
CONTAINER="tfstate"

az group create --name "$RG" --location "$LOCATION" --output none
az storage account create --name "$SA" --resource-group "$RG" --location "$LOCATION" \
  --sku Standard_LRS --min-tls-version TLS1_2 --allow-blob-public-access false --output none
az storage container create --name "$CONTAINER" --account-name "$SA" --auth-mode login --output none

cat <<MSG
State backend ready. Initialise Terraform with:

  terraform init \\
    -backend-config="resource_group_name=$RG" \\
    -backend-config="storage_account_name=$SA" \\
    -backend-config="container_name=$CONTAINER" \\
    -backend-config="key=bakery-<env>.tfstate"
MSG
