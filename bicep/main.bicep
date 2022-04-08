targetScope = 'subscription'

// If an environment is set up (dev, test, prod...), it is used in the application name
param environment string = 'dev'
param applicationName string = 'lzrsstwitter'
param location string = 'westeurope'
var instanceNumber = '001'

var defaultTags = {
  'environment': environment
  'application': applicationName
  'nubesgen-version': '0.11.2'
}

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: '${applicationName}-rg-${environment}-${instanceNumber}'
  location: location
  tags: defaultTags
}

var applicationEnvironmentVariables = [
// You can add your custom environment variables here
]

module function 'modules/function/function.bicep' = {
  name: 'function'
  scope: resourceGroup(rg.name)
  params: {
    location: location
    applicationName: applicationName
    environment: environment
    resourceTags: defaultTags
    instanceNumber: instanceNumber
    environmentVariables: applicationEnvironmentVariables
  }
}
