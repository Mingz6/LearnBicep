// From session 13 to 

// To run this bicep file, use the following command:
// az deployment group create -g <development-ming> -f 3.0SqlServerAndDb.bicep

param pSQLServer string

resource sqlServer 'Microsoft.Sql/servers@2014-04-01' = {
  name: 'azbicep-dev-eus-sqlserver-minglearn'
  location: resourceGroup().location
  properties: {
    administratorLogin: 'adminuser'
    administratorLoginPassword: 'adminPassword123'
  }
}

resource sqlServerDatabase 'Microsoft.Sql/servers/databases@2014-04-01' = {
  parent: sqlServer
  name: 'mingzdb'
  location: resourceGroup().location
  properties: {
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    edition: 'Basic'
    maxSizeBytes: '1073741824'
    requestedServiceObjectiveName: 'Basic'
  }
}

resource sqlServerFirewallRules 'Microsoft.Sql/servers/firewallRules@2021-02-01-preview' = {
  parent: sqlServer
  name: 'Ming IP address'
  properties: {
    startIpAddress: '1.1.1.1'
    endIpAddress: '1.1.1.1'
  }
}

