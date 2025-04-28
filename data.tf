data "hcp_vault_secrets_secret" "gh_token" {
  app_name    = "azure"
  secret_name = "GH_TOKEN"
}

data "hcp_vault_secrets_secret" "hmac" {
  app_name    = "azure"
  secret_name = "HMAC_KEY"
}

data "hcp_vault_secrets_secret" "new_relic_license_key" {
  app_name    = "azure"
  secret_name = "NEW_RELIC_LICENSE_KEY"
}

data "hcp_vault_secrets_secret" "tf_token" {
  app_name    = "azure"
  secret_name = "TF_TOKEN"
}