#!/bin/bash

RESOURCE_GROUP=""
BICEP_FILE="bicep_extract.bicep"

# Deploy the Bicep template
az deployment group create \
  --resource-group $RESOURCE_GROUP \
  --template-file $BICEP_FILE \
  --output json > deployment-output.json


# Save API keys to a .env file
apiKey1=$(jq -r '.properties.outputs.apiKey1.value' deployment-output.json)
AZURE_OPENAI_RESOURCE=$(jq -r '.properties.parameters.aiServicesName.value' deployment-output.json)
AZURE_OPENAI_PREVIEW_API_VERSION=$(jq -r '.properties.outputs.azurE_OPENAI_PREVIEW_API_VERSION.value' deployment-output.json)
AZURE_OPENAI_ENDPOINT=$(jq -r '.properties.outputs.azurE_OPENAI_ENDPOINT.value' deployment-output.json)
AZURE_OPENAI_EMBEDDING_ENDPOINT=$(jq -r '.properties.outputs.azurE_OPENAI_EMBEDDING_ENDPOINT.value' deployment-output.json)


# save the environmental variables to a .env file

# sed -i '' "s|^AZURE_OPENAI_ENDPOINT=.*|AZURE_OPENAI_ENDPOINT=$AZURE_OPENAI_ENDPOINT|" .env.sample
# sed -i '' "s|^AZURE_OPENAI_EMBEDDING_ENDPOINT=.*|AZURE_OPENAI_EMBEDDING_ENDPOINT=$AZURE_OPENAI_EMBEDDING_ENDPOINT|" .env.sample


# check if the sed command was successful

sed -i '' "s|^AZURE_OPENAI_RESOURCE=.*|AZURE_OPENAI_RESOURCE=$AZURE_OPENAI_RESOURCE|" .env.sample
if [ $? -ne 0 ]; then
  echo "Error: Failed to update AZURE_OPENAI_RESOURCE in .env file."
  exit 1
fi


sed -i '' "s|^AZURE_OPENAI_PREVIEW_API_VERSION=.*|AZURE_OPENAI_PREVIEW_API_VERSION=$AZURE_OPENAI_PREVIEW_API_VERSION|" .env.sample
if [ $? -ne 0 ]; then
  echo "Error: Failed to update AZURE_OPENAI_PREVIEW_API_VERSION in .env file."
  exit 1
fi

sed -i '' "s|^AZURE_OPENAI_KEY=.*|AZURE_OPENAI_KEY=$apiKey1|" .env.sample
if [ $? -ne 0 ]; then
  echo "Error: Failed to update AZURE_OPENAI_KEY in .env file."
  exit 1
fi

# If all 'sed' commands were successful, print confirmation
echo ".env file updated successfully with new values."


cat .env.sample | jq -R '. | capture("(?<name>[A-Z_]+)=(?<value>.*)")' | jq -s '.[].slotSetting=false' > env.json
if [ $? -eq 0 ]; then
  # If the conversion is successful, print "hello"
  echo "".env file created converted""
else
  echo "Error: Failed to convert .env.sample to JSON."
  exit 1
