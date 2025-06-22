# Deploy .NET App in Docker Swarm

1. Initialize Swarm:

```bash
docker swarm init
```

2. Deploy service:

```bash
docker service create --name myapp --replicas 3 -p 5000:80 myregistry.azurecr.io/myapp:latest
```

3. List services:

```bash
docker service ls
```

4. Scale service:

```bash
docker service scale myapp=5
```
