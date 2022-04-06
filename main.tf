resource "azurerm_resource_group" "main" {
  name     = "rg-checkov-validation-test"
  location = "UKSouth"
  tags = {
    owner = "Dom Routley"
  }
}

resource "azurerm_storage_account" "main" {
  # checkov:skip=CKV2_AZURE_1:We do not want to manage our own keys
  # checkov:skip=CKV2_AZURE_18:We do not want to manage our own keys
  # checkov:skip=CKV2_AZURE_8:This seems to be buggy, so is disabled. see > https://github.com/bridgecrewio/checkov/issues/2134
  # checkov:skip=CKV_AZURE_33:We are not using the queue service, so do not need this
  name                      = "st${var.name}"
  resource_group_name       = azurerm_resource_group.main.name
  location                  = azurerm_resource_group.main.location
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  enable_https_traffic_only = true
  min_tls_version           = "TLS1_2"
  network_rules {
    default_action = var.default_action
    bypass         = ["AzureServices"]
  }
}
