# Azure Web App Terraform Deployment

## Overview
This project provisions an Azure Web App environment using Terraform and Azure Verified Modules (AVM). It automates the creation of resource groups, App Service Plans, managed identities, federated credentials for GitHub Actions, and a Python-based Azure Web App for the Terraform Endpoint. Secret management is handled via HashiCorp Cloud Platform (HCP) Vault. Remote state is managed in Terraform Cloud.

## Features
- Automated resource group and App Service Plan creation
- User-assigned managed identity and federated credentials for GitHub Actions
- Deployment of a Python 3.12 Azure Web App with custom settings and environment variables, enables New Relic agent for monitoring
- Retrieval of sensitive values from HCP Vault
- Remote state management via Terraform Cloud

## Requirements
- Terraform >= 1.11.4
- Azure Subscription
- HCP account for Vault
- Terraform Cloud account (organization: `az-env`, workspace: `Terraform-Azure-AppService`)

## Notes
- Uses federated credentials for secure GitHub Actions workflows [Terrabridge App]
- Application secrets are retrieved securely from HCP Vault.
- The web app runs a Python application using Uvicorn.