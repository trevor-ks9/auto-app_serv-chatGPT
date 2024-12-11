#!/bin/bash

# Extrat Variable Names
APP_NAME=$(jq -r ".APP_NAME" app_vars.json)
RESOURCE_GROUP=$(jq -r ".RESOURCE_GROUP" app_vars.json)
LOCATION=$(jq -r ".LOCATION" app_vars.json)
SUBSCRIPTION=$(jq -r ".SUBSCRIPTION" app_vars.json)
RUNTIME=$(jq -r ".RUNTIME" app_vars.json)
SKU=$(jq -r ".SKU" app_vars.json)



# Create the web app
az webapp up --runtime "$RUNTIME" --sku "$SKU" --name "$APP_NAME" --resource-group "$RESOURCE_GROUP" --location "$LOCATION" --subscription "$SUBSCRIPTION"

