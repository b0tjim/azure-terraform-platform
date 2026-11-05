# Cheapest settings: burstable Postgres, scale to zero when idle.
environment       = "dev"
location          = "eastus2"
image_tag         = "v0.1.0"
postgres_sku_name = "B_Standard_B1ms"
min_replicas      = 0
max_replicas      = 1
