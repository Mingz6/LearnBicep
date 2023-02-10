# Create infra using bicep - Option 1

1. Create Params for each environment
2. Create Main.bicep for running different tasks
3. Create tasks under the core folder to implement script
4. Run the following script to deploy Azure resource.
   1. az identity create -g <group-name> -n <TheIdentityName>
   2. az deployment group create --resource-group <group-name> --subscription <YoursubscriptionId> --template-file main.bicep --parameters params.json --name learnbicep-2023-01-19

Step#1 is create user assigned 

# Create infra using bicep - Option 2

1. Create app registration using powershell.
2. Run the following command to deploy Azure resource.
   1. .\app-reg-application-cc.ps1 -tenantId <YourTenantId> -appName <YourAppName>