// To Create storage account in Azure for serverless application
// Run the following command in Azure CLI to deploy the bicep file
// az deployment group create --resource-group <resource-group-name> --template-file 5.0Serverless.bicep -p 5.0Serverless.parameters.json

param pLocation string
param pStorageAccountName string = resourceGroup().location
param pAppServicePlanName string
param pSkuCapacity int
param pSKUName string
param pFunctionAppName string

param pStartIndex int = 1
param pCount int = 5

module StorageAccount_Module '5.0StorageAccount.bicep' = {
  name: 'StorageAccount_Module'
  params: {
    pLocation: pLocation
    pStorageAccountName: pStorageAccountName
  }
}

module AppServicePlan_Linux '7.0AppServicePlan-Linux.bicep' = {
  name : 'AppServicePlan_Linux'
  params: {
    pAppServicePlanName: pAppServicePlanName
    pLocation: pLocation
    pSkuCapacity: pSkuCapacity
    pSKUName: pSKUName
  }
}


module AppInsights '4.0AppInsight.bicep' = {
  name: 'AppInsights'
  params:{
    pAppInsights: '${pFunctionAppName}-ai'
  }
}


module FunctionApp '7.0AzureFuncApp.bicep' = [ for index in range(pStartIndex, pCount): {
  name: 'FunctionApp-${index}'
  params: {
    pFuncName: '${pFunctionAppName}-${index}'
    pLocation: pLocation
    pServerFarmId: AppServicePlan_Linux.outputs.AppServicePlanId
    pStorageAccountName: StorageAccount_Module.outputs.storageAccountName
    pStorageAccountId: StorageAccount_Module.outputs.storageAccountId
    pAppInsightsId: AppInsights.outputs.oAppInsightsId
  }
}]
