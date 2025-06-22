FROM mcr.microsoft.com/dotnet/aspnet:6.0-windowsservercore-ltsc2022

WORKDIR /app
COPY publish/ .

# Import ServiceMonitor to monitor dotnet.exe
COPY ServiceMonitor.exe /ServiceMonitor.exe

ENTRYPOINT ["C:\ServiceMonitor.exe", "dotnet", "MyApp.dll"]
