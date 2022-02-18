# general
env_short = "p"
env       = "prod"
location  = "westeurope"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Prod"
  Owner       = "Common PagoPA"
  Source      = "https://github.com/pagopa/common-infra"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

lock_enable = true

# 🔐 key vault
key_vault_name    = "common-p-weu-kv"
key_vault_rg_name = "common-p-sec-rg"

keyvault_autogenerated_secrets = [
  "grafana-admin-password",
]

keyvault_raw_secrets = [
  {
    name  = "grafana-admin-user",
    value = "admin"
    type  = "username"
  }
]
