# 9. Docker Swarm Mode

0.) Introduction
Docker Swarm is a docker-native container orchestration tool 
built into the Docker Engine, therefore, it integrates well with 
Docker. It is used for simplifying the management of multiple 
containers of an application.

1.) Staring the cluster

To start an empty cluster you need to run the following command:
```shell
docker swarm init
```
This commands creates a swarm cluster and makes your current machine ```manager```.

You will be given a link similar to this one
```shell
docker swarm join --token SWMTKN-1-2bzmbmxm5cocmnj3b2ja1t89r3oyfx6y700dxaz3y544plw4is-3jy69w386tpt60d0z9jnwm5ey 192.168.0.107:2377
```
which could be used to join new machines to the cluster.
But we won't be using this command because configuring several machines to be used 
as the same cluster is complicated process and is out of our scope.

The following command shows all the machines joined to this cluster and their statuses
```shell
docker node ls
```

2.) Creating services with Docker commands

The following command allows us to run nginx services in a replica set of 3 instances:
```shell
docker service create --name my-nginx-service --replicas 3 nginx:1.25
```

See info about running service:
```shell
docker service ls
docker service ps my-nginx-service
```

Moreover, ```docker service``` command allows you to manage Swarm services.
```shell
docker service --help
```

Remove service:
```shell
docker service rm my-nginx-service
docker service ls
```

3.) Creating services with Docker Compose file

On the other hand, Docker Compose Files can be used to define multiple 
services and their dependencies, then deploy the Swarm as a stack. 
Let’s see how we can create a service with a Docker Compose file.

First, you need to create a ```docker-compose.yaml``` file, as shown below. 
Next, note that you need to create a stack to fit your use case. 
In this example stack, I have defined a web service with 2 replicas, 
api service with 2 replicas, and a db service with 1 replica.

```yaml
version: '3'

services:
 web:
   image: nginx
   ports:
     - "80:80"
   deploy:
     replicas: 3
 api:
   image: httpd
   deploy:
     replicas: 2
```

Running this command all the services listed in ```docker-compose.yaml``` file will be run:
```shell
docker stack deploy --compose-file docker-compose.yaml my-stack
```
List of your deployed stacks:
```shell
docker stack ls
```

Remove the stack and all its services and their containers
```shell
docker stack rm my-stack
```

4.) Service rolling updates

Rolling updates can be used to update a Docker service without causing 
downtime or service interruption. Docker Swarm updates each replica of 
the service one at a time to ensure that a certain number of replicas 
are always running. The rolling update strategy allows you to update a 
service without affecting its availability.

The following command allows you to 
```
docker service update [OPTIONS] SERVICE
```

Run, to see what exactly you can update
```shell
docker service update --help
```

Start nginx:1.25 service in 3 instances:
```shell
docker service create --name my-nginx-service --replicas 3 nginx:1.25
```

And increase number of replicas to 5:
```shell
docker service update --replicas 5 my-nginx-service
docker service ls
```
