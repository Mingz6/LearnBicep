// From session 17 to 17

// Param get from the main file.
param pAppInsights string

resource azbicepappinsights 'Microsoft.Insights/components@2020-02-02-preview'= {
  name: pAppInsights
  location: resourceGroup().location
  kind: 'web'
  properties: {
    Application_Type:'web'
  }
}

// Output param for other resources.
output oInstrumentationKey string = azbicepappinsights.properties.InstrumentationKey
output oAppInsightsId string = azbicepappinsights.id
