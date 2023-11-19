
# Dockerfile: building your own images

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
FROM eclipse-temurin:17-ubi9-minimal

WORKDIR /app

ARG JAR_FILE=target/*.jar

COPY ${JAR_FILE} backend.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "backend.jar"]
```

3.) Build a docker image: run this command inside **spring-petclinic** directory

```shell
cd spring-petclinic
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


6.) Multistage build Dockerfile

kubectl - is a util for managing Kubernetes entities. kubectl-kustomize - also.

But just for now don`t mind about it: those are just cli utils which are needed for us inside the image.
For example, it will be used in runtime inside the container of during build of another image based on this one.

Put this script inside the **Dockerfile_multistage** file

```dockerfile
FROM bitnami/kubectl:1.27.3 AS kubectl

FROM line/kubectl-kustomize:1.27.3-5.1.0 AS kustomize

FROM docker:20.10.24

COPY --from=kubectl /opt/bitnami/kubectl/bin/kubectl /usr/local/bin/

COPY --from=kustomize /usr/local/bin/kustomize /usr/local/bin/

RUN apk update && apk add --no-cache curl bash gettext jq sudo htop yq git sudo
```

Run the following command to build an image from a new file:
```shell
docker build . -f Dockerfile_multistage
```

> **Important:** Run the following command second time you will see information that soma layers has been taken from the cache and were not built another time
