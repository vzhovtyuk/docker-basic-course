# Practice: run MySQL server


1.) Install a mysql client
```shell
sudo apt install mysql-client-8.0
```
Try it out:
```shell
mysql --version
```

2.) Run mysql in docker
```shell
docker run -d -p 3306:3306 mysql
```
3.) Container status is ```Exited```
```shell
docker ps -a
```

4.) See logs of the container
```shell
docker logs <container_id>
```

You will see something like this:

```
2023-09-20 10:34:24+00:00 [Note] [Entrypoint]: Entrypoint script for MySQL Server 8.1.0-1.el8 started.
2023-09-20 10:34:25+00:00 [Note] [Entrypoint]: Switching to dedicated user 'mysql'
2023-09-20 10:34:25+00:00 [Note] [Entrypoint]: Entrypoint script for MySQL Server 8.1.0-1.el8 started.
2023-09-20 10:34:25+00:00 [ERROR] [Entrypoint]: Database is uninitialized and password option is not specified
You need to specify one of the following as an environment variable:
- MYSQL_ROOT_PASSWORD
- MYSQL_ALLOW_EMPTY_PASSWORD
- MYSQL_RANDOM_ROOT_PASSWORD
```

5.) Delete already created container
```
docker rm <container_id>
```

Specify password using env variable MYSQL_ROOT_PASSWORD
```shell
docker run \
-d \
-p 3306:3306 \
-e MYSQL_ROOT_PASSWORD=password1234 \
-e MYSQL_DATABASE=my_main_db \
--name mysqlserver \
mysql
```

Connect to mysql write password in the prompt: password1234
```
mysql -u root -h 127.0.0.1 -p
```

Perform some actions in the database
```sql
SHOW DATABASES;
USE my_main_db;
CREATE TABLE person(id int primary key, name varchar(255));
SHOW TABLES;
INSERT INTO person (id, name) VALUES (1, "Jake");
SELECT * FROM person;
exit;
```



Stop and remove container -> data will be lost (it has been storing inside the container itself)
```
docker stop mysqlserver
docker rm mysqlserver
```

Now all your data is stored inside _~/local-directory_
and you may restart your container any times, delete it, create new, 
but with the same config: data will be safe
```shell
docker run \
-d \
-p 3306:3306 \
-e MYSQL_ROOT_PASSWORD=password1234 \
-e MYSQL_DATABASE=my_main_db \
-v ~/local-directory:/var/lib/mysql \
--name mysqlserver \
mysql
```

Do something with this database, perform some scripts...

Cleanup:
```
docker stop mysqlserver
docker rm mysqlserver
```

# Dockerfile: building your own images

0.) Install git and download a Pet Clinic project from github repository

Installing Git
```shell
sudo apt install git
```

Then clone the repo
```shell
cd ~
git clone https://github.com/spring-projects/spring-petclinic.git
cd ./spring-petclinic
```

1.) Create a **Dockerfile**

Create a file with name **Dockerfile** (without extension) inside **spring-petclinic** directory
```shell
touch Dockerfile
```

Put this script inside the **Dockerfile** file

```dockerfile
FROM openjdk:17-jdk-alpine

WORKDIR /app

ARG JAR_FILE=target/*.jar

COPY ${JAR_FILE} backend.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "backend.jar"]
```

2.) Build a docker image: run this command inside **spring-petclinic** directory

```shell
docker build . --tag petclinic
```

This command will build an image from **Dockerfile** file inside this directory and with name **petclinic:latest**
> **Hint:** --tag (-t) flag gives a specified name to your image. 
> It is a good practice to use it always when you build an image

3.) Run container

```shell
docker run --name petclinic -p 9000:8080 --rm petclinic
```

> **Hint:** Use flag ```--rm``` for ```docker run command``` to automatically remove the container after it is stopped

4.) Stop container using Ctrl+C, for example, - it will be automatically removed

# Docker-compose

0.) Open docker-compose.yaml file and delete all its content

1.) Put this configuration inside docker-compose.yaml file

```yaml
# If only the major version is given (version: '3'), the latest minor version is used by default.
version: "3"

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
    ports:
      - "3306:3306"
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

[a relative link](other_file.md)