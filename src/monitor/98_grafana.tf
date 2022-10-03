resource "azurerm_resource_group" "grafana_dashboard_rg" {
  name     = "${local.project}-grafana-dashboard-rg"
  location = var.location

  tags = var.tags
}

resource "azurerm_dashboard_grafana" "grafana_dashboard" {
  name                              = "${local.project}-grafana"
  resource_group_name               = azurerm_resource_group.grafana_dashboard_rg.name
  location                          = var.location
  api_key_enabled                   = false
  deterministic_outbound_ip_enabled = true
  public_network_access_enabled     = true
  zone_redundancy_enabled           = true

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

resource "azurerm_management_lock" "grafana_dashboard" {
  name       = azurerm_dashboard_grafana.grafana_dashboard.name
  scope      = azurerm_dashboard_grafana.grafana_dashboard.id
  lock_level = "CanNotDelete"
}

resource "azurerm_role_assignment" "grafana_dashboard_monitoring_reader" {
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Monitoring Reader"
  principal_id         = azurerm_dashboard_grafana.grafana_dashboard.identity[0].principal_id
}

resource "azurerm_monitor_diagnostic_setting" "grafana_dashboard" {
  count                      = var.env_short == "p" ? 1 : 0
  name                       = "SecurityLogs"
  target_resource_id         = azurerm_dashboard_grafana.grafana_dashboard.id
  log_analytics_workspace_id = data.azurerm_key_vault_secret.sec_workspace_id[0].value
  storage_account_id         = data.azurerm_key_vault_secret.sec_storage_id[0].value

  log {
    category_group = "audit"
    enabled        = true
    retention_policy {
      enabled = true
      days    = 365
    }
  }

  log {
    category_group = "allLogs"
    enabled        = true
    retention_policy {
      enabled = true
      days    = 365
    }
  }

  metric {
    category = "AllMetrics"
    enabled  = false

    retention_policy {
      days    = 0
      enabled = false
    }
  }
}
