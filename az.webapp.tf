# App Service Plan
module "appservice" {
  source              = "Azure/avm-res-web-serverfarm/azurerm"
  version             = "0.5.0"

  name                = module.naming.app_service_plan.name_unique
  resource_group_name = module.resource_group.name
  location            = var.location
  os_type             = "Linux"
  sku_name            = "F1"
  zone_balancing_enabled = false
  worker_count        = 1

  tags                = var.tags
}

# User Assigned iD for Web App
resource "azurerm_user_assigned_identity" "tf_id" {
  name                = "terrabridge-id-b0ac"
  resource_group_name = module.resource_group.name
  location            = var.location

  tags                = var.tags
}
# Federated Credentials for the User Assigned Identity
resource "azurerm_federated_identity_credential" "github_actions" {
  name                = "shelvinx-terrabridge-8817"
  resource_group_name = module.resource_group.name
  parent_id           = azurerm_user_assigned_identity.tf_id.id
  audience            = ["api://AzureADTokenExchange"]
  issuer              = "https://token.actions.githubusercontent.com"
  subject             = "repo:shelvinx/terrabridge:environment:Azure"
}

# Web App Configuration
module "webapp" {
  source                    = "Azure/avm-res-web-site/azurerm"
  version                   = "0.16.4"

  name                      = var.webapp_name
  resource_group_name       = module.resource_group.name
  location                  = var.location
  service_plan_resource_id  = module.appservice.resource_id
  kind                      = "webapp"
  os_type                   = "Linux"
  https_only                = true
  enable_application_insights = false
  managed_identities = {
    user_assigned_resource_ids = [
      azurerm_user_assigned_identity.tf_id.id
    ]
  }
  
  role_assignments = {
    webapp_contributor = {
      role_definition_id_or_name = "Contributor"
      principal_id               = azurerm_user_assigned_identity.tf_id.principal_id
    }
  }

  site_config = {
    always_on         = false
    linux_fx_version  = "PYTHON|3.12"
    use_32_bit_worker = true
    app_command_line  = "NEW_RELIC_CONFIG_FILE=newrelic.ini newrelic-admin run-program uvicorn run_task_service:app --host 0.0.0.0 --port 3000"
  }

  app_settings = {
    GH_TOKEN              = data.hcp_vault_secrets_secret.gh_token.secret_value
    GITHUB_REPOSITORY     = var.github_repository
    HMAC_KEY              = data.hcp_vault_secrets_secret.hmac.secret_value
    NEW_RELIC_LICENSE_KEY = data.hcp_vault_secrets_secret.new_relic_license_key.secret_value
    PORT                  = var.port
    TF_TOKEN              = data.hcp_vault_secrets_secret.tf_token.secret_value
    SCM_DO_BUILD_DURING_DEPLOYMENT = 1
  }

  tags                      = var.tags
}