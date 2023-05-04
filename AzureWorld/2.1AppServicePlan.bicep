// To run this bicep file, use the following command:
// az deployment group create -g <development-ming> -f 2.1AppServicePlan.bicep

// Preview before deploy using what if command
// az deployment group create -g <development-ming> -f .\AzureWorld\2.1AppServicePlan.bicep --confirm-with-what-if

// parameters
param pAppServicePlan string
param pAppService string
param pInstrumentationKey string
param pEvn string

@description('''
  Please select the SKU name for the App Service Plan.
  The allowed values are:
  F1, B1, B2, B3, D1, D2, D3, S1, S2, S3, P1V2, P2V2, P3V2, P1V3, P2V3, P3V3
  ''')
@allowed(['F1', 'B1', 'B2', 'B3', 'D1', 'D2', 'D3', 'S1', 'S2', 'S3', 'P1V2', 'P2V2', 'P3V2', 'P1V3', 'P2V3', 'P3V3'])
param pSkuName string

@minValue(1)
@maxValue(30)
param pSkuCapacity int

// App service plan
resource azbicepasp1 'Microsoft.web/serverfarms@2020-12-01'= {
   // App service name
   // name: 'azbicep-dev-eus-asp1'
  name: pAppServicePlan
  location: resourceGroup().location
  sku: {
    name: pSkuName
    capacity: pSkuCapacity
  }
}

resource WebAppSlot 'Microsoft.Web/sites/slots@2022-03-01' = if (pEvn == 'dev') {
  name: 'azbicep-dev-eus-wapp1-staging-ming'
  location: resourceGroup().location
  parent: azbicepas
  properties: {
    serverFarmId: azbicepasp1.id
  }
  dependsOn: [
    azbicepasp1
  ]
}

// AZ Web app
resource azbicepas 'Microsoft.web/sites@2018-11-01'= {
   // name: 'azbicep-dev-eus-wapp1-ming'
  name: pAppService
  location: resourceGroup().location
  properties: {
    serverFarmId: resourceId('Microsoft.web/serverfarms', 'azbicep-dev-eus-asp1')
  }
  dependsOn: [
    azbicepasp1
  ]
}

// This add app setting to the AZ web app above
resource azbicepwebapp1appsetting 'Microsoft.web/sites/config@2018-11-01'= {
  name: 'web'
  parent: azbicepas
  properties: {
    appSettings: [
      {
        name: 'key1'
        value: 'value1'
      }
      {
        name: 'key2'
        value: 'value2'
      }
      {
        name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
        value: pInstrumentationKey
      }
    ]
  }
}

// This app insights is moved to 4.0AppInsights.bicep
// resource azbicepappinsights 'Microsoft.Insights/components@2020-02-02-preview'= {
//   name: 'azbicep-dev-eus-wapp1-ai'
//   location: resourceGroup( ).location
//   kind: 'web'
//   properties: {
//     Application_Type: 'web'
//   }
// }
