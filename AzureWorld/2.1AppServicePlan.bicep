resource azbicepasp1 'Microsoft.web/serverfarms@2020-12-01'= {
  name: 'azbicep-dev-eus-asp1' // App service name
  location: resourceGroup().location
  sku: {
    name: 'S1'
    capacity: 1
  }
}

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

// az deployment group create -g <development-ming> -f 2.1AppServicePlan.bicep

// Preview before deploy using what if command
// az deployment group create -g <development-ming> -f 2.1AppServicePlan.bicep --confirm-with-what-if
