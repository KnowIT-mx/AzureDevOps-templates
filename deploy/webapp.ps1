"[command][+] Resource Group [$env:AZURE_RESOURCEGROUP]..."
az group create --name $env:AZURE_RESOURCEGROUP --location $env:AZURE_LOCATION
az configure --defaults group=$env:AZURE_RESOURCEGROUP

"[command][+] Application Service Plan [$env:APPSERVICE_NAME]..."
az appservice plan create --name $env:APPSERVICE_NAME --is-linux --sku $env:APPSERVICE_TIER

"[command][+] WebApp [$env:WEBAPP]..."
az webapp create --name $env:WEBAPP --plan $env:APPSERVICE_NAME --runtime """DOTNETCORE|$env:NETCORE_VERSION"""
if($env:WEBAPP_SLOT) {
    az webapp deployment slot create --name $env:WEBAPP --slot $env:WEBAPP_SLOT
}
az webapp config connection-string set --name $env:WEBAPP --connection-string-type SQLAzure --settings default="""$env:CONN_STRING"""
$identity = az webapp identity assign --name $env:WEBAPP --resource-group $env:AZURE_RESOURCEGROUP --query principalId -o tsv
az keyvault set-policy -n $env:AZURE_RESOURCEGROUP --secret-permissions get list --object-id $identity
