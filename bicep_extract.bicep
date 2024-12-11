@description('That name is the name of our application. It has to be unique.Type a name followed by your resource group name. (<name>-<resourceGroupName>)')
param aiServicesName string = 'App_name--${uniqueString(resourceGroup().id)}'

@description('Location for all resources.')
param location string = resourceGroup().location

@allowed([
  'S0'
])
param sku string = 'S0'

resource account 'Microsoft.CognitiveServices/accounts@2023-05-01' = {
  name: aiServicesName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  sku: {
    name: sku
  }
  kind: 'OpenAI'
  properties: {
    publicNetworkAccess: 'Enabled'
    networkAcls: {
      defaultAction: 'Allow'
    }
    
    }
  
  }

  resource gpt4 'Microsoft.CognitiveServices/accounts/deployments@2024-04-01-preview' = {
    parent: account
    name: '${aiServicesName}GPT4'
    sku: {
      name: 'Standard'
      capacity: 1
    }
    properties: {
      model: {
        format: 'OpenAI' 
        name: 'gpt-35-turbo'
        version: '0125'
      }
     
      versionUpgradeOption: 'OnceNewDefaultVersionAvailable'
      currentCapacity: 10
      raiPolicyName: 'Microsoft.Default'
    }
  }



// 'output keys'
output apiKey1 string = listKeys(account.id, '2023-05-01').key1
output apiKey2 string = listKeys(account.id, '2023-05-01').key2
// Outputs for extracting specific values
output AZURE_OPENAI_RESOURCE string = account.name
output AZURE_OPENAI_PREVIEW_API_VERSION string = '0125'
output AZURE_OPENAI_ENDPOINT string = account.properties.endpoint
output AZURE_OPENAI_EMBEDDING_ENDPOINT string = account.properties.endpoint
output AZURE_OPENAI_EMBEDDING_KEY string = listKeys(account.id, '2023-05-01').key1 // Assuming this is the key you need
