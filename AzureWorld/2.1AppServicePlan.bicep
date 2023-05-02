// From session 6 to 12

// To run this bicep file, use the following command:
// az deployment group create -g <development-ming> -f 2.1AppServicePlan.bicep

// Preview before deploy using what if command:
// az deployment group create -g <development-ming> -f .\AzureWorld\2.1AppServicePlan.bicep --confirm-with-what-if

// App service plan
resource azbicepasp1 'Microsoft.web/serverfarms@2020-12-01'= {
  name: 'azbicep-dev-eus-asp1' // App service name
  location: resourceGroup().location
  sku: {
    name: 'S1'
    capacity: 1
  }
}

// AZ Web app
resource azbicepas 'Microsoft.web/sites@2018-11-01'= {
  name: 'azbicep-dev-eus-wapp1-ming'
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
        value: azbicepappinsights.properties.InstrumentationKey
      }
    ]
  }
}

resource azbicepappinsights 'Microsoft.Insights/components@2020-02-02-preview'= {
  name: 'azbicep-dev-eus-wapp1-ai'
  location: resourceGroup( ).location
  kind: 'web'
  properties: {
    Application_Type: 'web'
  }
}
