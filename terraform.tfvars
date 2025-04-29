# terraform.tfvars
# General variables
suffix_workload = "terrabridge"
location        = "uksouth"

# Tags
tags = {
  created_by = "terraform"
}

# Web App
webapp_name       = "terrabridge"
github_repository = "shelvinx/ansible-playbooks"
port              = "3000"