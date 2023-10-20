# 8. Networking in Docker

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
* bridge (the most common, enables DNS resolution for containers)
* host (just runs a container in localhost interface like simple, not very secure)
* overlay
* ipvlan
* macvlan
* none (completely isolates a container from the host and other containers)
* third-party network plugins

In our basic course we`ll cover only the bridge docker network driver practically.

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

4.) Check visibility

Run nginx server inside ```petclinic-custom-net```
```shell
docker run --rm -d --name nginx-in-same-network --net=petclinic-custom-net nginx:1.25
```

Install ping inside nginx container **(do not do this on prod!)**
```shell
docker exec -it nginx-in-same-network bash
apt update -y
apt install -y iputils-ping
```

Ping a petclinic app - it should work
```shell
ping petclinic
```

Go out from container:
```shell
exit
```

Then try to perform this from another network.

Create a new network
```shell
docker network create --driver=bridge another-custom-net
```

And run nginx server inside ```another-custom-net```
```shell
docker run --rm -d --name nginx-in-another-network --net=another-custom-net nginx:1.25
```

And perform just the same:

Install ping inside nginx container **(do not do this on prod!)**
```shell
docker exec -it nginx-in-another-network bash
apt update -y
apt install -y iputils-ping
```

Ping a petclinic app - now it will fail due to failure in name resolution
```shell
ping petclinic
```
Go out from container:
```shell
exit
```


> **Hint:** Docker Compose by default creates a network and runs all the containers inside it. 
> That is why they can communicate with each other.

5.) Stop containers and remove custom networks

Stop and remove containers:
```shell
docker rm -f petclinic
docker rm -f mysql-server
docker rm -f nginx-in-same-network
docker rm -f nginx-in-another-network
```
Flag ```-f``` forces removing the container: it stops if it is running and removes

Remove network:
```shell
docker network rm petclinic-custom-net
docker network rm another-custom-net
```
