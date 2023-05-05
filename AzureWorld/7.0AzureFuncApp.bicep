param pLocation string
param pServerFarmId string
param pFuncName string
param pStorageAccountName string
param pStorageAccountId string
param pAppInsightsId string

resource azureFunction 'Microsoft.Web/sites@2020-12-01' = {
  name: 'azbicep-dev-eus-fapp-001'
  location: pLocation
  kind: 'functionapp'
  properties: {
    serverFarmId: pServerFarmId
    siteConfig: {
      appSettings: [
        {
          name: 'AzureWebJobsDashboard'
          // This value is coming from Access Keys of the storage account
          // value: 'DefaultEndpointsProtocol=https;AccountName=storageAccountName1;AccountKey=${listKeys('storageAccountID1', '2019-06-01').key1}'
          
          // Get Properties from params
          value: 'DefaultEndpointsProtocol=https;AccountName=${pStorageAccountName};AccountKey=${listKeys(pStorageAccountId, '2019-06-01').key[0].value}'
        }
        {
          name: 'AzureWebJobsStorage'
          // value: 'DefaultEndpointsProtocol=https;AccountName=storageAccountName2;AccountKey=${listKeys('storageAccountID2', '2019-06-01').key1}'
        }
        {
          name: 'WEBSITE_CONTENTAZUREFILECONNECTIONSTRING'
          // value: 'DefaultEndpointsProtocol=https;AccountName=storageAccountName3;AccountKey=${listKeys('storageAccountID3', '2019-06-01').key1}'
        }
        {
          name: 'WEBSITE_CONTENTSHARE'
          value: toLower(pFuncName)
        }
        {
          name: 'FUNCTIONS_EXTENSION_VERSION'
          value: '~4'
        }
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          // Copy the Application Insights Instrumentation Key from the Application Insights resource
          // value: reference('insightsComponents.id', '2015-05-01').InstrumentationKey

          // Get it from params
          value: reference(pAppInsightsId, '2015-05-01').InstrumentationKey
        }
        {
          name: 'FUNCTIONS_WORKER_RUNTIME'
          value: 'dotnet'
        }
      ]
    }
  }
}
