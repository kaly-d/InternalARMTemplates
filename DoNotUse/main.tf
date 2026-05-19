data "azurerm_client_config" "current" {}

locals { ###
  sentinel_managed_api_id = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/providers/Microsoft.Web/locations/${var.location}/managedApis/azuresentinel"
  effective_display_name  = coalesce(var.display_name, var.connection_name)
} ###

resource "azapi_resource" "sentinel_api_connection" { ##
  type      = "Microsoft.Web/connections@2016-06-01"
  name      = var.connection_name
  location  = var.location
  parent_id = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${var.resource_group_name}"

  schema_validation_enabled = false

  body = { ####
    properties = { #####
      displayName = local.effective_display_name
      api = { ######
        id = local.sentinel_managed_api_id
      } ######

      # Managed Identity switch (matches the ARM pattern you already used successfully)
      parameterValueType = "Alternative"
      parameterValueSet  = {}
    } #####
  } ####

  response_export_values = ["*"]
} ##
