# PARTE 2

## Extracción del contenedor del registro
docker pull mcr.microsoft.com/mssql/server:2022-latest

## 
docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=Passw1rd" -p 1433:1433 --name sql_server -d mcr.microsoft.com/mssql/server:2022-latest