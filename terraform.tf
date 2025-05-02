# Terraform Providers
terraform {
  required_version = ">= 1.11.4"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.26.0"
    }
    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.104.0"
    }
  }

  # Configure Terraform Cloud for Remote State Management
  cloud {
    organization = "az-env"
    workspaces {
      name = "az-webapp"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  resource_provider_registrations = "extended"
}

# HCP Provider - used for Vault
provider "hcp" {
  client_id     = var.HCP_CLIENT_ID
  client_secret = var.HCP_CLIENT_SECRET
}