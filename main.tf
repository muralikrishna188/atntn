terraform {
  backend "azurerm" {
      resource_group_name = "backend-eastus-rg"
      storage_account_name = "backendeastus"
      container_name = "stage"
      key = "terraform.stage"
      access_key = "BS6NCIhq1IvNmunWeZeXzKLTHusqgeofTG87OHftcmAAgyZTpr5MQZec+3JqOkp2AG4WUY1HIGaA+AStx0SnZQ=="
  }
}

variable "subscription_id" {
    type = string
    default = "049cc0b9-2696-4e70-871b-4366be487c19"
    description = "dev subscription id"
  
}
variable "client_id" {
    type = string
    default = "4d3b8936-70cc-4927-9d9e-cfbfb6588b0b"
    description = "dev- client id"
  
}
variable "client_secret" {
    type = string
    default = "z.a7Q~usQOj2pdgCT1VmUvNZKIYtbG.4qarWn"
    description = "dev-client secret"
  
}
variable "tenant_id" {
    type = string
    default = "477cf0a5-266c-4331-8f0a-865f4622d888"
  
}


provider "azurerm" {
    features {
      
    }
    subscription_id = var.subscription_id
    client_id = var.client_id
    client_secret = var.client_secret
    tenant_id = var.tenant_id
    
}
locals {
  setup_name = "practice-hyd"
}

resource "azurerm_resource_group" "webapplabel262" {
    name = "webapp232rg"
    location = "East US"
    tags = {
      "name" = "${local.setup_name}-rsg"
    }

}

resource "azurerm_service_plan" "appplanlabel125" {
    name = "appserviceplanprod"
    location = azurerm_resource_group.webapplabel262.location
    resource_group_name = azurerm_resource_group.webapplabel262.name
    sku_name = "P1v2"
    os_type = "Linux"
    tags = {
        name = "${local.setup_name}-appplan"
    }
    depends_on = [
      azurerm_resource_group.webapplabel262
    ]

  
}

resource "azurerm_app_service" "webapplabel116" {
    name = "webapp25874"
    location = azurerm_resource_group.webapplabel262.location
    resource_group_name = azurerm_resource_group.webapplabel262.name
    app_service_plan_id = azurerm_service_plan.appplanlabel125.id
    tags = {
      "name" = "${local.setup_name}-webapp"
    }
    depends_on = [
      azurerm_service_plan.appplanlabel125
    ]
}