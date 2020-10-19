"[+] Resource Group [$env:AZURE_RESOURCEGROUP]..."
az group create --name $env:AZURE_RESOURCEGROUP --location $env:AZURE_LOCATION

"[+] Storage Account [$env:AZURE_STORAGE_ACCOUNT]..."
az storage account create -n $env:AZURE_STORAGE_ACCOUNT -g $env:AZURE_RESOURCEGROUP --sku Standard_LRS --query 'primaryEndpoints'

# El valor del parametro --account-name se toma de las variables del entorno AZURE_SORAGE_ACCOUNT
az storage blob service-properties update --static-website --index-document 'index.html' --404-document 'index.html' --auth-mode login --query '{StaticWebSite:staticWebsite}'
