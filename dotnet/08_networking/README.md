# Custom Docker Network with .NET + SQL Server

Create a custom network:

```bash
docker network create dotnet-network
```

Run SQL Server:

```bash
docker run -d --name sqlserver --network dotnet-network -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=YourStrong!Passw0rd" mcr.microsoft.com/mssql/server:2019-latest
```

Run Web API:

```bash
docker run -d --name webapi --network dotnet-network -p 5000:80 myappimage
```

In your connection string, use `Server=sqlserver;` to connect.
