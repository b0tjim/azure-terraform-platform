locals {
  tags = merge({ project = var.project, environment = var.environment, managed_by = "terraform" }, var.tags)
}

# Short suffix keeps the globally unique Key Vault name unique per deployment.
resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
}

# No special characters so the password is safe to embed in the connection URL.
resource "random_password" "db" {
  length  = 32
  special = false
}

module "resource_group" {
  source      = "./modules/resource-group"
  project     = var.project
  environment = var.environment
  location    = var.location
  tags        = local.tags
}

module "log_analytics" {
  source              = "./modules/log-analytics"
  project             = var.project
  environment         = var.environment
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  tags                = local.tags
}

module "postgres" {
  source                 = "./modules/postgres"
  project                = var.project
  environment            = var.environment
  resource_group_name    = module.resource_group.name
  location               = module.resource_group.location
  sku_name               = var.postgres_sku_name
  administrator_password = random_password.db.result
  tags                   = local.tags
}

module "key_vault" {
  source                   = "./modules/key-vault"
  project                  = var.project
  environment              = var.environment
  name_suffix              = random_string.suffix.result
  resource_group_name      = module.resource_group.name
  location                 = module.resource_group.location
  db_password              = random_password.db.result
  purge_protection_enabled = var.environment == "prod"
  database_url = format(
    "postgresql+psycopg://%s:%s@%s/%s?sslmode=require",
    module.postgres.administrator_login,
    random_password.db.result,
    module.postgres.fqdn,
    module.postgres.database_name,
  )
  tags = local.tags
}

module "container_app" {
  source                     = "./modules/container-app"
  project                    = var.project
  environment                = var.environment
  resource_group_name        = module.resource_group.name
  location                   = module.resource_group.location
  log_analytics_workspace_id = module.log_analytics.id
  key_vault_id               = module.key_vault.id
  database_url_secret_id     = module.key_vault.database_url_secret_id
  image                      = var.image
  image_tag                  = var.image_tag
  min_replicas               = var.min_replicas
  max_replicas               = var.max_replicas
  tags                       = local.tags
}
