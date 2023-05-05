param pAppServicePlanName string
param pSkuCapacity int
param pSKUName string
param pLocation string

resource appServicePlan 'Microsoft.web/serverfarms@2020-12-01'= {
  name : pAppServicePlanName
  location: pLocation
  kind: 'linux'
  properties: {
    reserved: true
  }
  sku: {
    name: pSKUName
    capacity: pSkuCapacity
  }
}

output AppServicePlanId string = appServicePlan.id
