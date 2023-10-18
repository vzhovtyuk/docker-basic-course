
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
1.) Install sdkman: https://sdkman.io

```shell
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk version
```

Install java 17 and Maven 
```shell
sdk install java 17.0.7-oracle
sdk install maven
```

Try Java and Maven:
```shell
java -version
mvn -version
```

2.) Create a **Dockerfile**

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

3.) Build a docker image: run this command inside **spring-petclinic** directory

```shell
docker build . --tag petclinic
```

This command will build an image from **Dockerfile** file inside this directory and with name **petclinic:latest**
> **Hint:** --tag (-t) flag gives a specified name to your image.
> It is a good practice to use it always when you build an image

4.) Run container

```shell
docker run --name petclinic -p 9000:8080 --rm petclinic
```

> **Hint:** Use flag ```--rm``` for ```docker run command``` to automatically remove the container after it is stopped

5.) Stop container using Ctrl+C, for example, - it will be automatically removed


| [4. MySQL, environment variables](4_mysql_environment_variables.md) | [Main page](README.md) | [6. Working with remote repository](6_remote_repository.md) |
|---------------------------------------------------------------------|------------------------|-------------------------------------------------------------|
