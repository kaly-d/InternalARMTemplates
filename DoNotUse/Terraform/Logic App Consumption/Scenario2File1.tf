#######################################
# terraform configuration
#######################################

terraform {
  required_version = ">= 1.5"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

#######################################
# variable configuration
#######################################


variable "subscription_id" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "logic_app_name" {
  type = string
}


#######################################
# resources
#######################################


resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_logic_app_workflow" "logicapp" {
  name                = var.logic_app_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_logic_app_trigger_http_request" "example" {
  name         = "some-http-trigger123"
  logic_app_id = azurerm_logic_app_workflow.logicapp.id

  schema = <<SCHEMA
{
    "type": "object",
    "properties": {
        "hello": {
            "type": "string"
        }
    }
}
SCHEMA

}

#######################################
# outputs
#######################################


output "logic_app_id" {
  value = azurerm_logic_app_workflow.logicapp.id
}

output "logic_app_name" {
  value = azurerm_logic_app_workflow.logicapp.name
}
