param name string
param location string = resourceGroup().location
param tags object = {}
param currentTime string = utcNow()

resource script 'Microsoft.Resources/deploymentScripts@2019-10-01-preview' = {
  name: name
  location: location
  tags: tags
  kind: 'AzurePowerShell'
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${resourceId('<group-name>', 'Microsoft.ManagedIdentity/userAssignedIdentities', '<learnbicep-app-reg-creator>')}': {}
    }
  }
  properties: {
    azPowerShellVersion: '5.0'
    arguments: '-resourceName "${name}"'
    scriptContent: '''
      $output = \'Hello World.\'
      Write-Output $output
      $DeploymentScriptOutputs = @{}
      $DeploymentScriptOutputs[\'text\'] = $output
    '''
    cleanupPreference: 'OnSuccess'
    retentionInterval: 'P1D'
    forceUpdateTag: currentTime // ensures script will run every time
  }
}

output objectId string = script.properties.outputs.objectId
output clientId string = script.properties.outputs.clientId
output clientSecret string = script.properties.outputs.clientSecret
output principalId string = script.properties.outputs.principalId
