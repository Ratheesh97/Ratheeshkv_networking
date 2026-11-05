#!/bin/bash

# 1. Resource Group உருவாக்குதல்
az group create --name my-network-rg --location eastus

# 2. Virtual Network மற்றும் Subnet உருவாக்குதல்
az network vnet create \
  --name my-vnet \
  --resource-group my-network-rg \
  --subnet-name my-subnet \
  --address-prefixes 10.0.0.0/16 \
  --subnet-prefixes 10.0.1.0/24
