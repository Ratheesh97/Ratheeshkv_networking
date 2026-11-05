# Azure Provider செட்டப்
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# 1. Resource Group உருவாக்குதல்
resource "azurerm_resource_group" "example" {
  name     = "my-network-rg"
  location = "East US"
}

# 2. Virtual Network (VNet) உருவாக்குதல்
resource "azurerm_virtual_network" "example" {
  name                = "my-vnet"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  address_space       = ["10.0.0.0/16"]
}

# 3. Subnet உருவாக்குதல்
resource "azurerm_subnet" "example" {
  name                 = "my-subnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
}
