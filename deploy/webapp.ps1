"[command][+] Resource Group [$env:AZURE_RESOURCEGROUP]..."
az group create --name $env:AZURE_RESOURCEGROUP --location $env:AZURE_LOCATION
az configure --defaults group=$env:AZURE_RESOURCEGROUP

"[command][+] Application Service Plan [$env:APPSERVICEPLAN]..."
az appservice plan create --name $env:APPSERVICEPLAN --is-linux --sku B1

"[command][+] WebApp [$env:WEBAPP]..."
az webapp create --name $env:WEBAPP --plan $env:APPSERVICEPLAN --runtime '"DOTNETCORE|LATEST"'
az webapp identity assign --name $env:WEBAPP --resource-group $env:AZURE_RESOURCEGROUP
az webapp config connection-string set --name $env:WEBAPP --connection-string-type SQLAzure --settings default="""$env:CONN_STRING"""
