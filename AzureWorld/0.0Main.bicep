// This is main entry point of your Bicep files.
// developers can work on the modules independently.

// This params can be used without the ARM template parameters file
// param pAppServicePlan string = 'azbicep-dev-eus-asp1'
// param pAppService string = 'azbicep-dev-eus-wapp1'
// param pAppInsights string = 'azbicep-dev-eus-wapp1-ai'
// param pSQLServer string = 'azbicep-dev-eus-sqlserver'

// Run this command can genenrate the ARM template
// bicep build .\0.0Main.bicep
// Use this section with the ARM template parameters file
// Use this command to deploy your main template
// az deployment group create -g <YourGroup> -f 0.Main.bicep -p 0.main.<YourEnv>.parameters.json
param Env string
param pAppServicePlan string
param pAppService string
param pAppInsights string
param pSQLServer string

param pSKUName string = (Env == 'dev')? 'F1': 'S1'

resource KeyVault 'Microsoft.KeyVault/vaults@2022-07-01' existing = {
  name: 'azbicep-dev-eus-kv-minglearn'
}

module AppServicePlan '2.1AppServicePlan.bicep' = {
  name: 'AppServicePlan'
  params:{
    pAppServicePlan: pAppServicePlan
    pAppService: pAppService
    pInstrumentationKey: AppInsights.outputs.oInstrumentationKey
    pSkuName: 'S1'
    pSkuCapacity: 25
    pEvn: Env
  }
}

module SQLDatabase '3.0SqlServerAndDb.bicep' = {
  name: 'SQLDatabase'
  params:{
    pSQLServer: pSQLServer
    pSQLServerAdminLogin: 'sqladmin'
    pSQLServerAdminPassword: KeyVault.getSecret('sqladminpassword')
  }
}

module AppInsights '4.0AppInsight.bicep' = {
  name: 'AppInsights'
  params:{
    pAppInsights: pAppInsights
  }
}
