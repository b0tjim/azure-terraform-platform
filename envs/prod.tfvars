# Always-on, two replicas, larger general-purpose Postgres.
environment       = "prod"
location          = "eastus2"
image_tag         = "v0.1.0"
postgres_sku_name = "GP_Standard_D2s_v3"
min_replicas      = 2
max_replicas      = 4
