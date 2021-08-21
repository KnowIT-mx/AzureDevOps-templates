"[command][+] Resource Group [$env:AZURE_RESOURCEGROUP]..."
#az group create --name $env:AZURE_RESOURCEGROUP --location $env:AZURE_LOCATION
az configure --defaults group=$env:AZURE_RESOURCEGROUP

#"[command][+] Crea/configura AzureSQL Server [$env:DBSERVER]..."
#az sql server create --name $env:DBSERVER --admin-user dios --admin-password $env:DBPASSWORD
#az sql server firewall-rule create --server $env:DBSERVER -n AllowAllAzureServiceIps --start-ip-address 0.0.0.0 --end-ip-address 0.0.0.0

"[command][*] Validando si existe la base de datos..."
$db = az sql db list --server $env:DBSERVER | ConvertFrom-Json
if($env:DBNAME -notin $db.name) {
    "[command][+] Crea nueva base de datos..."
    az sql db create --name $env:DBNAME --server $env:DBSERVER --service-objective Basic
}