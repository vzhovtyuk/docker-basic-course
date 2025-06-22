# .NET Core + ServiceMonitor on Windows

This example demonstrates using `ServiceMonitor.exe` to run and monitor a .NET Core application inside a Windows container.

## Steps

1. Publish your app (e.g. via Visual Studio or CLI):

```bash
dotnet publish -c Release -o publish
```

2. Place the output in the `publish/` folder.

3. Download `ServiceMonitor.exe` from official sources or copy from an existing IIS container.

4. Build the image:

```powershell
docker build -t dotnetcore-servicemonitor .
```

5. Run the container:

```powershell
docker run -d -p 5000:80 dotnetcore-servicemonitor
```

Then navigate to http://localhost:5000
