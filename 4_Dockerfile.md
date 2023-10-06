
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


| [3. MySQL and environment variables ](3_mysql_environment_variables.md) | [Main page](README.md) | [5. Docker compose ](5_docker_compose.md) |
|-------------------------------------------------------------------------|------------------------|-------------------------------------------|
