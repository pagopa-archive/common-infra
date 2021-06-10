resource "azurerm_resource_group" "rg_reg" {
  name     = format("%s-reg-rg", local.project)
  location = var.location
  tags     = var.tags
}

module "acr" {
  source              = "git::https://github.com/pagopa/azurerm.git//container_registry?ref=main"
  name                = replace(format("%s-acr", local.project), "-", "")
  resource_group_name = azurerm_resource_group.rg_reg.name
  location            = azurerm_resource_group.rg_reg.location
  admin_enabled       = false

  tags = var.tags
}
