output "sentinel_connection_id" {
  value       = azapi_resource.sentinel_api_connection.id
  description = "Resource ID of the Sentinel API connection"
}

output "sentinel_managed_api_id" {
  value       = local.sentinel_managed_api_id
  description = "Managed API ID used by the connection"
}
