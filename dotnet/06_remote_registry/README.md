# Push .NET Image to Azure Container Registry (ACR)

1. Log in to Azure:

```bash
az login
```

2. Log in to your registry:

```bash
az acr login --name myregistry
```

3. Build the image:

```bash
docker build -t myregistry.azurecr.io/myapp:latest .
```

4. Push the image:

```bash
docker push myregistry.azurecr.io/myapp:latest
```

5. Run it from registry:

```bash
docker run -p 5000:80 myregistry.azurecr.io/myapp:latest
```
