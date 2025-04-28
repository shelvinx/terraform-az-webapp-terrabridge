variable "HCP_CLIENT_SECRET" {
  description = "The client secret for HCP"
  type        = string
  sensitive   = true
}

variable "HCP_CLIENT_ID" {
  description = "The client ID for HCP"
  type        = string
  sensitive   = true
}

variable "suffix_workload" {
  type = string
  description = "Suffix for the workload"
}

variable "location" {
  type = string
  description = "Location for the resource group"
}

variable "tags" {
  type = map(string)
  description = "Tags for the resource group"
}

variable "webapp_name" {
  type = string
  description = "Name for the web app"
}

variable "github_repository" {
  type = string
  description = "GitHub repository for the web app"
}

variable "port" {
  type = string
  description = "Port for the web app"
}
