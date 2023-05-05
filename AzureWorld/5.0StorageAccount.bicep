param pStorageAccountName string
param pLocation string = resourceGroup().location

resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: pStorageAccountName
  location: pLocation
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}

output storageAccountId string = storageaccount.id
output storageAccountName string = storageaccount.name

