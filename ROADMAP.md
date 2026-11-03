# Roadmap

Terraform that hosts the [bakery-orders-api](https://github.com/b0tjim/bakery-orders-api) container on Azure.
No Azure credentials are used in development: nothing here is ever planned or applied from the sandbox.

- [x] 1. Repo skeleton: README stub, .gitignore, .editorconfig, LICENSE
- [x] 2. Root Terraform config: versions.tf, providers.tf, variables.tf, outputs.tf
- [x] 3. Remote state: azurerm backend block (partial config) + `scripts/bootstrap-state.sh` to create the storage account
- [ ] 4. Module `resource-group` (naming + tags)
- [ ] 5. Module `log-analytics` workspace
- [ ] 6. Module `postgres` (Flexible Server, database, firewall rule for Azure services)
- [ ] 7. Module `key-vault` (RBAC mode) storing the generated DB password
- [ ] 8. Module `container-app` (Container Apps environment wired to Log Analytics + app pulling the GHCR image)
- [ ] 9. Container App secret from Key Vault via user-assigned managed identity; `DATABASE_URL` env wiring
- [ ] 10. Compose modules in the root config and add outputs (app URL, vault name)
- [ ] 11. `envs/dev.tfvars` and `envs/prod.tfvars` (sizes, replicas, SKUs)
- [ ] 12. CI: `terraform fmt -check` and `terraform validate` (backend disabled)
- [ ] 13. CI: tflint with azurerm ruleset and `.tflint.hcl`
- [ ] 14. CI: checkov scan, with documented skips for deliberate cost tradeoffs
- [ ] 15. Plan workflow: OIDC `azure/login`, skips cleanly when Azure vars are absent
- [ ] 16. Apply workflow gated behind a manual-approval `production` environment, also skips cleanly
- [ ] 17. README: architecture diagram (Mermaid), module overview, how to run locally with `-backend=false`
- [ ] 18. README: federated identity (OIDC) setup steps with `az` commands and required repo variables
- [ ] 19. README: rough monthly cost estimate for dev and prod
- [ ] 20. Badges, "what this demonstrates" section, final polish, tag `v0.1.0`
