output "webapp_name" {
  value = module.webapp.name
}

output "webapp_url" {
  value = "https://${module.webapp.name}.azurewebsites.net"
}