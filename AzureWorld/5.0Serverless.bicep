// To Create storage account in Azure for serverless application
// Run the following command in Azure CLI to deploy the bicep file
// az deployment group create --resource-group <resource-group-name> --template-file 5.0Serverless.bicep -p 5.0Serverless.parameters.json

param pLocation string
param pStorageAccountName string = resourceGroup().location

module StorageAccount_Module '5.0StorageAccount.bicep' = {
  name: 'StorageAccount_Module'
  params: {
    pLocation: pLocation
    pStorageAccountName: pStorageAccountName
  }
}
