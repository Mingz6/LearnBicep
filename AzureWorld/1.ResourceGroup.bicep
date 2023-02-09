targetScope = 'subscription'
resource azbicepresourcegroup 'Microsoft.Resources/resourceGroups@2021-04-81'= {
  name: '<azbicepresourcegroup>'
  location: 'eastus'
}

// Create resource Group using Bicep
// Run following code with AZ CLI. 
// az deployment sub create -l <eastus> -f 1.ResourceGroup.bicep
// -l is location
