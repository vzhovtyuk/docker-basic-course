# Docker-compose

0.) Open docker-compose.yaml file inside a _petclinic project_ and delete all its content

1.) Put this configuration inside docker-compose.yaml file

```yaml
version: "3.9"

services:
  petclinic:
    build: .
    restart: always
    ports:
      - "9000:8080"
    environment:
      - SPRING_PROFILES_ACTIVE=default,mysql
      - MYSQL_URL=jdbc:mysql://mysql/petclinic
      - MYSQL_USER=petclinic
      - MYSQL_PASSWORD=petclinic
    depends_on:
      - mysql


  mysql:
    container_name: database
    image: mysql:8.0
    restart: always
    environment:
      - MYSQL_ROOT_PASSWORD=password # just needed for root user
      - MYSQL_USER=petclinic
      - MYSQL_PASSWORD=petclinic
      - MYSQL_DATABASE=petclinic
    volumes:
      - ./dbdata:/var/lib/mysql


  # username = petclinic
  # password = petclinic
  # db = petclinic
  adminer_container:
    image: adminer:latest
    environment:
      ADMINER_DEFAULT_SERVER: mysql
    ports:
      - "8080:8080"
    depends_on:
      - mysql

```
2.) Execute this command to run all the services together

```shell
docker compose up -d
```

3.) Execute this command to see the logs of all the containers.
-f (--follow) flag is used to follow the logs in runtime

```shell
docker compose logs -f
```

> **Hint:** You can specify service names to see the logs of only several of them
> ```
> docker compose logs -f mysql adminer_container
> ```
> This will show logs only of **mysql** and **adminer_container**

4.) Execute this command to stop all the containers

```shell
docker compose down
```

> **Hint:** ```docker compose down``` stops and removes the containers.
>
> Instead, you may run this command:
> ```shell
> docker compose stop
> ```
> and all the containers will be only stopped. So you may run ```docker compose up -d``` again and those containers will restart.

This will lead to slow startup of service: limits work fine


5.) Instruction ```depends_on``` by default checks whether the **dependency**
container has started, but it does not care if the application inside the container
already started. That is why we need to use health checks to make dependent cotainers 
waiting for their dependencies **really** started.

```yaml
version: "3.9"

services:
  petclinic:
    build: .
    restart: always
    ports:
      - "9000:8080"
    environment:
      - SPRING_PROFILES_ACTIVE=default,mysql
      - MYSQL_URL=jdbc:mysql://mysql/petclinic
      - MYSQL_USER=petclinic
      - MYSQL_PASSWORD=petclinic
    depends_on:
      mysql:
        condition: service_healthy


  mysql:
    container_name: database
    image: mysql:8.0
    restart: always
    environment:
      - MYSQL_ROOT_PASSWORD=password # just needed for root user
      - MYSQL_USER=petclinic
      - MYSQL_PASSWORD=petclinic
      - MYSQL_DATABASE=petclinic
    volumes:
      - ./dbdata:/var/lib/mysql
    healthcheck:
      test: mysqladmin ping -h localhost -upetclinic -ppetclinic
      interval: 5s
      timeout: 2s
      retries: 5
      start_period: 10s


  # username = petclinic
  # password = petclinic
  # db = petclinic
  adminer_container:
    image: adminer:latest
    environment:
      ADMINER_DEFAULT_SERVER: mysql
    ports:
      - "8080:8080"
    depends_on:
      mysql:
        condition: service_healthy
```
Healthcheck properties:
* **test** - the command which will be executed and is the health check of the container
* **interval** - the frequency at which subsequent health checks will be performed
* **timeout** - number of seconds Docker awaits for your health check command to return an exit code before declaring it as failed
* **retries** - the number of consecutive health check failures required to declare the container as unhealthy
* **start_period** - the number of seconds your container needs to bootstrap. During this period, health checks with an exit code greater 
than zero won’t mark the container as unhealthy; however, a status code of 0 will mark the container as healthy


| [4. Dockerfile ](5_Dockerfile.md) | [Main page](README.md) | [6. /dev/null ](README.md) |
|-----------------------------------|------------------------|----------------------------|
