"[command][+] Resource Group [$env:AZURE_RESOURCEGROUP]..."
az group create --name $env:AZURE_RESOURCEGROUP --location $env:AZURE_LOCATION
az configure --defaults group=$env:AZURE_RESOURCEGROUP

"[command][+] Application Service Plan [$env:WEBAPP_SERVICEPLAN]..."
az appservice plan create --name $env:WEBAPP_SERVICEPLAN --is-linux --sku B1

"[command][+] WebApp [$env:WEBAPP_NAME]..."
az webapp create --name $env:WEBAPP_NAME --plan $env:WEBAPP_SERVICEPLAN --runtime """$env:WEBAPP_RUNTIME"""
az webapp identity assign --name $env:WEBAPP_NAME --resource-group $env:AZURE_RESOURCEGROUP
#az webapp config connection-string set --name $env:WEBAPP_NAME --connection-string-type SQLAzure --settings default="""$env:CONN_STRING"""
