resource azbicepasp1 'Microsoft.web/serverfarms@2020-12-01'= {
  name: 'azbicep-dev-eus-asp1' // App service name
  location: resourceGroup().location
  sku: {
    name: 'S1'
    capacity: 1
  }
}

// Create service plan
// az deployment group create -g <development-ming> -f 2.0AppServicePlan.bicep


resource azbicepasp2 'Microsoft.web/serverfarms@2020-12-01'= {
  name: 'azbicep-dev-eus-linux-asp1'
  kind: 'linux'
  properties: {
    reserved: true
  }
  location: resourceGroup( ).location
  sku: {
    name: 's1'
    capacity: 1
  }
}

// Create Linux service plan
// az deployment group create -g <development-ming> -f 2.0AppServicePlan.bicep
