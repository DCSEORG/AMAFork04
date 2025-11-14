// Azure App Service Infrastructure for Expense Management System
// Deploys App Service with low-cost development SKU in UK South

@description('Name of the App Service')
param appServiceName string

@description('Location for all resources')
param location string = 'uksouth'

@description('App Service Plan SKU - using low-cost development tier')
param appServicePlanSku string = 'B1'

@description('App Service Plan tier')
param appServicePlanTier string = 'Basic'

// App Service Plan
resource appServicePlan 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: '${appServiceName}-plan'
  location: location
  sku: {
    name: appServicePlanSku
    tier: appServicePlanTier
  }
  kind: 'linux'
  properties: {
    reserved: true
  }
}

// App Service
resource appService 'Microsoft.Web/sites@2022-09-01' = {
  name: appServiceName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: 'DOTNETCORE|8.0'
      alwaysOn: false
      ftpsState: 'Disabled'
      minTlsVersion: '1.2'
      http20Enabled: true
      appSettings: [
        {
          name: 'ASPNETCORE_ENVIRONMENT'
          value: 'Development'
        }
      ]
    }
    httpsOnly: true
  }
}

// Outputs
output appServiceName string = appService.name
output appServiceUrl string = appService.properties.defaultHostName
output appServiceId string = appService.id
