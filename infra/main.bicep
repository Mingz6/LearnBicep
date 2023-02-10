@secure()
param tags object
param environmentName string
param location string = resourceGroup().location

var base = 'learnbicep'

var appRegisName = 'stapp-learnbicep-${base}-${environmentName}'
module appRegis './core/appRegistration.bicep' = {
  name: appRegisName
  params: {
    name: appRegisName
    location: location
    tags: tags
  }
}

// az deployment group create --resource-group <group-name> --subscription <****-****-****-****> --template-file main.bicep --parameters <paramsDev.json> --name <learnbicep-2023-01-19>
