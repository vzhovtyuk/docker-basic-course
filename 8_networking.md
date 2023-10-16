# 6. Networking in Docker

1.) Introduction

To see the list of existing networks run command:
```shell
docker network ls
```
By default, 3 networks already exist: ```default bridge```, ```host``` and ```none```.
If you run a container without specifying a network the ```default bridge``` will be used.
When you start Docker, a ```default bridge``` network is created automatically, 
and newly-started containers connect to it unless otherwise specified. 
In ```default bridge``` no DNS resolution enabled, so containers cannot see each other(isolated).

Network driver in docker is a network type. Available drives:
* bridge (the most common)
* host (just runs a container in localhost interface like simple, not very secure)
* overlay
* ipvlan
* macvlan
* none (completely isolates a container from the host and other containers)
* third-party network plugins

In our basic course we`ll cover only the bridge docker network driver.

2.) Creating a network.

This command creates a network of type bridge with name ```petclinic-custom-net``` 
```shell
docker network create --driver=bridge petclinic-custom-net
```
Custom ```bridge``` networks automatically enable DNS resolution: services are able
to access each other using their names as hosts. 


3.) Running containers in the same network.

Start mysql-server in a newly created network
```shell
docker run --rm -d \
--name mysql-server \
--net petclinic-custom-net \
-e MYSQL_ROOT_PASSWORD=password \
-e MYSQL_USER=petclinic \
-e MYSQL_PASSWORD=petclinic \
-e MYSQL_DATABASE=petclinic \
-p 3306:3306 \
mysql:8.0
```

Start petclinic backend in a newly created network
```shell
docker run --rm -d \
--name petclinic \
--net petclinic-custom-net \
-e SPRING_PROFILES_ACTIVE=default,mysql \
-e MYSQL_URL=jdbc:mysql://mysql-server/petclinic \
-e MYSQL_USER=petclinic \
-e MYSQL_PASSWORD=petclinic \
-p 9000:8080 \
petclinic:latest
```
You see that ```jdbc:mysql://mysql-server/petclinic``` database connection url contains ```mysql-server```
container name as a host. It will be resolved by DNS to local IP address in ```petclinic-custom-net``` network.

> **Hint:** ```docker compose down``` stops and removes the containers.
> Docker Compose by default creates a network and runs all the containers inside it. 
> That is why they can communicate with each other.

4.) Stop containers and remove custom network

Stop and remove containers:
```shell
docker stop petclinic
docker stop mysql-server

docker rm petclinic
docker rm mysql-server
```

Remove network:
```shell
docker network rm petclinic-custom-net
```


| [4. Dockerfile ](5_Dockerfile.md) | [Main page](README.md) | [6. /dev/null ](README.md) |
|-----------------------------------|------------------------|----------------------------|
