# general

variable "prefix" {
  type    = string
  default = "common"
  validation {
    condition = (
      length(var.prefix) <= 6
    )
    error_message = "Max length is 6 chars."
  }
}

variable "env_short" {
  type = string
  validation {
    condition = (
      length(var.env_short) <= 1
    )
    error_message = "Max length is 1 chars."
  }
}

variable "location" {
  type    = string
  default = "westeurope"
}

variable "lock_enable" {
  type        = bool
  default     = false
  description = "Apply locks to block accedentaly deletions."
}

variable "tags" {
  type = map(any)
  default = {
    CreatedBy = "Terraform"
  }
}

#
# 🔐 Key Vault
#
variable "key_vault_name" {
  type        = string
  description = "Key Vault name"
  default     = ""
}

variable "key_vault_rg_name" {
  type        = string
  default     = ""
  description = "Key Vault - rg name"
}

#
# Locals
#
locals {
  monitor_rg                      = format("%s-monitor-rg", local.project)
  monitor_action_group_slack_name = "SlackPagoPA"
  monitor_action_group_email_name = "PagoPA"
}
