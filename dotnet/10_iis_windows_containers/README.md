# ASP.NET + IIS on Windows Containers

This example shows how to run a legacy ASP.NET app on IIS inside a Windows container.

## Build the image

```powershell
docker build -t legacy-iis-app .
```

## Run the container

```powershell
docker run -d -p 8080:80 legacy-iis-app
```

Now access it via http://localhost:8080
